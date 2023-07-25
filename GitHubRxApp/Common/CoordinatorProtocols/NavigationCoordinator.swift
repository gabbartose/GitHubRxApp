//
//  NavigationCoordinator.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

protocol NavigationCoordinator: Coordinator {
    var rootViewController: UINavigationController { get }
    init(rootViewController: UINavigationController, dependencyManager: DependencyManager)
}
