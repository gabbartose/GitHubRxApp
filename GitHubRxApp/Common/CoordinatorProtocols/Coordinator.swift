//
//  Coordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func shouldRemoveCoordinator(coordinator: Coordinator)
}

protocol Coordinator: NSObjectProtocol {
    var childCoordinators: [Coordinator] { get set }
    var dependencyManager: DependencyManager { get }
    func start()
}

extension Coordinator {
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
    }

    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}
