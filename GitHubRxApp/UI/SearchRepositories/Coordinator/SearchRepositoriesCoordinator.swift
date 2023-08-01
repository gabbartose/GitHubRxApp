//
//  SearchRepositoriesCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

protocol UserDetailsDelegate: AnyObject {
    func didSelectUserDetails(userDetails: Owner)
}

class SearchRepositoriesCoordinator: NSObject, NavigationCoordinator {
    
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var dependencyManager: DependencyManager
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }
    
    func start() {
        let searchRepositoriesRepository = SearchRepositoriesRepository(networkManager: dependencyManager.networkManager)
        let searchRepositoriesViewModel = SearchRepositoriesViewModel(searchRepositoriesRepository: searchRepositoriesRepository)
        searchRepositoriesViewModel.delegate = self
        let searchRepositoriesViewController = SearchRepositoriesViewController(
            viewModel: searchRepositoriesViewModel)
        rootViewController.pushViewController(searchRepositoriesViewController, animated: true)
    }
    
    deinit {
        print("deinit SearchRepositoriesCoordinator")
    }
}

// MARK: Open RepositoryDetails
extension SearchRepositoriesCoordinator: SearchRepositoriesViewModelDelegate {
    func showLoginScreen() {
        
    }
    
    func didSelectRepository(item: Item) {
        let repositoryDetailsCoordinator = RepositoryDetailsCoordinator(rootViewController: rootViewController, dependencyManager: dependencyManager)
        addChildCoordinator(repositoryDetailsCoordinator)
        repositoryDetailsCoordinator.delegate = self
        repositoryDetailsCoordinator.startWith(repositoryItem: item)
    }
}

// MARK: Open UserDetails
extension SearchRepositoriesCoordinator: RepositoryDetailsCoordinatorDelegate {
    func didSelectUserDetails(userDetails: Owner) {
        let userDetailsCoordinator = UserDetailsCoordinator(rootViewController: rootViewController, dependencyManager: dependencyManager)
        addChildCoordinator(userDetailsCoordinator)
        userDetailsCoordinator.delegate = self
        userDetailsCoordinator.startWith(userDetails: userDetails)
    }
}

// MARK: Open AdditionalInfoInBrowser (info about Repositories and Users via HTML in browser)
extension SearchRepositoriesCoordinator: UserDetailsCoordinatorDelegate {
    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        URL.openLinkInWebBrowser(htmlURL: htmlURL)
    }
}

extension SearchRepositoriesCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
