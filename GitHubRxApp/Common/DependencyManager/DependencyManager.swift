//
//  DependencyManager.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

final class DependencyManager {
    var networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}
