//
//  LoginCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit

protocol LoginCoordinatorDelegate: CoordinatorDelegate { }

class LoginCoordinator: NSObject, NavigationCoordinator {
    
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var dependencyManager: DependencyManager
    
    weak var delegate: LoginCoordinatorDelegate?
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }

    func start() {
        fatalError("use startWith")
    }
    
    func startWith() {
        let loginViewModel = LoginViewModel()
        loginViewModel.delegate = self
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        rootViewController.pushViewController(loginViewController, animated: true)
    }
    
    deinit {
        print("deinit LoginCoordinator")
    }
}

extension LoginCoordinator: LoginViewModelDelegate {
    func didEnd() {
        delegate?.shouldRemoveCoordinator(coordinator: self)
    }
}

extension LoginCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
