//
//  RepositoriesResponse.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct RepositoriesResponse: Codable, Equatable {
    let items: [Item]
}
