//
//  AppCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
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
        UINavigationBar.appearance().barTintColor = .white
        let navigationBar = rootViewController.navigationBar
        let appearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.font: UIFont(name: .ralewayBold, size: 20), NSAttributedString.Key.foregroundColor: UIColor.setColor(.GBlue)]
        appearance.titleTextAttributes = attributes as [NSAttributedString.Key: Any]
        appearance.backgroundColor = .white
        navigationBar.standardAppearance = appearance
        navigationBar.isTranslucent = false
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        showMainFlow()
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

extension AppCoordinator {
    private func showMainFlow() {
        let searchRepositoriesCoordinator = SearchRepositoriesCoordinator(rootViewController: rootViewController,
                                                                          dependencyManager: dependencyManager)
        addChildCoordinator(searchRepositoriesCoordinator)
        searchRepositoriesCoordinator.start()
    }
}
