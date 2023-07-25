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

protocol ExternalBrowserDelegate: AnyObject {
    func didTapAdditionalInfoInBrowser(htmlURL: String)
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
        let repositoriesRepository = RepositoriesRepository(networkManager: dependencyManager.networkManager)
        let searchRepositoriesViewModel = SearchRepositoriesViewModel(repositoriesRepository: repositoriesRepository)
        searchRepositoriesViewModel.delegate = self
        let searchRepositoriesViewController = SearchRepositoriesViewController(
            viewModel: searchRepositoriesViewModel)
        rootViewController.pushViewController(searchRepositoriesViewController, animated: true)
    }
}

// MARK: Open RepositoryDetails
extension SearchRepositoriesCoordinator: SearchRepositoriesViewModelDelegate {
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
        guard let url = URL(string: htmlURL) else { return }
        UIApplication.shared.open(url)
    }
}

extension SearchRepositoriesCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
