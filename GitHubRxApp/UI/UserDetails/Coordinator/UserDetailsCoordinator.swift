//
//  UserDetailsCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit

protocol UserDetailsCoordinatorDelegate: CoordinatorDelegate { }

final class UserDetailsCoordinator: NSObject, NavigationCoordinator {
    var rootViewController: UINavigationController
    var dependencyManager: DependencyManager
    var childCoordinators: [Coordinator] = []
    
    weak var delegate: UserDetailsCoordinatorDelegate?
    
    required init(rootViewController: UINavigationController, dependencyManager: DependencyManager) {
        self.rootViewController = rootViewController
        self.dependencyManager = dependencyManager
    }
    
    func start() {
        fatalError("use startWith")
    }
    
    func startWith(userDetails: Owner) {
        let userDetailsViewModel = UserDetailsViewModel(userDetails: userDetails)
        userDetailsViewModel.delegate = self
        let userDetailsViewController = UserDetailsViewController(viewModel: userDetailsViewModel)
        rootViewController.view.layer.add(CATransition.setTransition(), forKey: nil)
        rootViewController.pushViewController(userDetailsViewController, animated: false)
    }
    
    deinit {
        print("deinit UserDetailsCoordinator")
    }
}

extension UserDetailsCoordinator: UserDetailsViewModelDelegate {
    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        URL.openLinkInWebBrowser(htmlURL: htmlURL)
    }
    
    func didEnd() {
        delegate?.shouldRemoveCoordinator(coordinator: self)
    }
}

extension UserDetailsCoordinator: CoordinatorDelegate {
    func shouldRemoveCoordinator(coordinator: Coordinator) {
        removeChildCoordinator(coordinator)
    }
}
