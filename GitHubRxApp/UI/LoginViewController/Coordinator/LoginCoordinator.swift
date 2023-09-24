//
//  LoginCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit

protocol LoginCoordinatorDelegate: CoordinatorDelegate { }

final class LoginCoordinator: NSObject, NavigationCoordinator {
    
    var rootViewController: UINavigationController
    var dependencyManager: DependencyManager
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: LoginCoordinatorDelegate?
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }
    
    func start() {
        let loginRepository = LoginRepository(networkManager: dependencyManager.networkManager)
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
    func showSearchRepositoriesScreen() {
        let searchRepositoriesRepository = SearchRepositoriesRepository(networkManager: dependencyManager.networkManager)
        let searchRepositoriesViewModel = SearchRepositoriesViewModel(searchRepositoriesRepository: searchRepositoriesRepository)
        searchRepositoriesViewModel.delegate = self
        let searchRepositoriesViewController = SearchRepositoriesViewController(
            viewModel: searchRepositoriesViewModel)
        rootViewController.pushViewController(searchRepositoriesViewController, animated: true)
    }
    
    func didEnd() {
        delegate?.shouldRemoveCoordinator(coordinator: self)
    }
}

extension LoginCoordinator: SearchRepositoriesViewModelDelegate, RepositoryDetailsCoordinatorDelegate, UserDetailsCoordinatorDelegate {
    func didSelectRepository(item: Item) {
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(rootViewController: rootViewController, dependencyManager: dependencyManager)
        addChildCoordinator(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.delegate = self
        repositoryDetailsCoordinator.startWith(repositoryItem: item)
    }
    
    func didSelectUserDetails(userDetails: Owner) {
        let userDetailsCoordinator = UserDetailsCoordinator(rootViewController: rootViewController, dependencyManager: dependencyManager)
        addChildCoordinator(userDetailsCoordinator)
        userDetailsCoordinator.delegate = self
        userDetailsCoordinator.startWith(userDetails: userDetails)
    }
    
    func didTapSignOutButton() {
        start()
    }
}

extension LoginCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
