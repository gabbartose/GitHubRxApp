//
//  Owner.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import Foundation

struct Owner: Codable, Equatable {
    
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let login: String?
    let type: String?
    let siteAdmin: Bool?
    let htmlUrl: String?
}
