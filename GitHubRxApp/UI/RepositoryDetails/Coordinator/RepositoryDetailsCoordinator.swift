//
//  RepositoryDetailsCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 20.07.2023..
//

import UIKit

protocol RepositoryDetailsCoordinatorDelegate: CoordinatorDelegate, UserDetailsDelegate { }

final class RepositoryDetailsCoordinator: NSObject, NavigationCoordinator {
    
    var rootViewController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var dependencyManager: DependencyManager
    
    weak var delegate: RepositoryDetailsCoordinatorDelegate?
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }
    
    func start() {
        fatalError("use startWith")
    }
    
    func startWith(repositoryItem: Item) {
        let repositoryDetailsViewModel = RepositoryDetailsViewModel(repositoryItem: repositoryItem)
        repositoryDetailsViewModel.delegate = self
        let repositoryDetailsViewController = RepositoryDetailsViewController(viewModel: repositoryDetailsViewModel)
        rootViewController.pushViewController(repositoryDetailsViewController, animated: true)
    }
    
    deinit {
        print("deinit RepositoryDetailsCoordinator")
    }
}

extension RepositoryDetailsCoordinator: RepositoryDetailsViewModelDelegate {
    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        URL.openLinkInWebBrowser(htmlURL: htmlURL)
    }
    
    func didEnd() {
        delegate?.shouldRemoveCoordinator(coordinator: self)
    }
}

extension RepositoryDetailsCoordinator: UserDetailsDelegate {
    func didSelectUserDetails(userDetails: Owner) {
        delegate?.didSelectUserDetails(userDetails: userDetails)
    }
}

extension RepositoryDetailsCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
