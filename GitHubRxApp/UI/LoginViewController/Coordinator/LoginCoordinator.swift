//
//  LoginCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit
import SafariServices

protocol LoginCoordinatorDelegate: CoordinatorDelegate { }

class LoginCoordinator: NSObject, NavigationCoordinator {
    
    var rootViewController: UINavigationController
    var dependencyManager: DependencyManager
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: LoginCoordinatorDelegate?
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }
    
    func start() {
        fatalError("use startWith")
    }
    
    func startWith() {
        let loginRepository = LoginRepository(/*networkManager: dependencyManager.networkManager*/)
        let loginViewModel = LoginViewModel(loginRepository: loginRepository)
        loginViewModel.delegate = self
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        rootViewController.pushViewController(loginViewController, animated: true)
    }
    
    deinit {
        print("deinit LoginCoordinator")
    }
}

extension LoginCoordinator: LoginViewModelDelegate {
    func getAuthPageURL(with url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
        rootViewController.present(safariViewController, animated: true)
    }
    
    func showSearchRepositoriesScreen() {
        let searchRepositoriesRepository = SearchRepositoriesRepository(networkManager: dependencyManager.networkManager)
        let searchRepositoriesViewModel = SearchRepositoriesViewModel(searchRepositoriesRepository: searchRepositoriesRepository)
        // searchRepositoriesViewModel.delegate = self
        let searchRepositoriesViewController = SearchRepositoriesViewController(
            viewModel: searchRepositoriesViewModel)
        rootViewController.pushViewController(searchRepositoriesViewController, animated: true)
    }
    
    func didEnd() {
        delegate?.shouldRemoveCoordinator(coordinator: self)
    }
}

extension LoginCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
