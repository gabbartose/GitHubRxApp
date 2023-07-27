//
//  Item.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct Item: Codable, Equatable {
    let id: Int?
    let name: String?
    let owner: Owner?
    let watchersCount: Int?
    let forksCount: Int?
    let stargazersCount: Int?
    let openIssues: Int?
    let language: String?
    let createdAt: String?
    let updatedAt: String?
    let htmlUrl: String?
    let description: String?
}
