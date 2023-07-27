//
//  AppCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    let deepLinkHandler = DeepLinkHandler()
    
    lazy var dependencyManager: DependencyManager = {
        let configuration = NetworkConfiguration(HTTPHeaders: getHTTPHeaders())
        let networkManager = NetworkManager(configuration: configuration)
        return DependencyManager(networkManager: networkManager)
    }()
    
    private let rootViewController = UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("Current environment is: \(EnvironmentProvider.shared.currentEnvironment)")
        
        showLoginFlow()
        
        // setupNavigationBar()
        // showSearchRepositoriesFlow()
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

// MARK: Required HTTP headers
extension AppCoordinator {
    private func getHTTPHeaders() -> [String: String] {
        var HTTPHeaders = [String: String]()
        HTTPHeaders["Content-Type"] = "application/json"
        HTTPHeaders["Accept"] = "application/json"
        HTTPHeaders["X-App-OS"] = "iOS"
        
        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            HTTPHeaders["X-App-Version"] = version
        }
        
        return HTTPHeaders
    }
}

// MARK: Navigation
extension AppCoordinator {
    private func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(rootViewController: rootViewController,
                                                dependencyManager: dependencyManager)
        addChildCoordinator(loginCoordinator)
        loginCoordinator.startWith()
    }
    
    private func showSearchRepositoriesFlow() {
        let searchRepositoriesCoordinator = SearchRepositoriesCoordinator(rootViewController: rootViewController,
                                                                          dependencyManager: dependencyManager)
        addChildCoordinator(searchRepositoriesCoordinator)
        searchRepositoriesCoordinator.start()
    }
}

// MARK: Setup UINavigationBar
extension AppCoordinator {
    private func setupNavigationBar() {
        UINavigationBar.appearance().barTintColor = .white
        let navigationBar = rootViewController.navigationBar
        let appearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: .ralewayBold, size: 20), NSAttributedString.Key.foregroundColor: UIColor.setColor(.GBlue)]
        appearance.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
        appearance.backgroundColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.isTranslucent = false
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
