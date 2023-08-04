//
//  RepositoriesResponse.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

// GitHub API info:
/*
 // URL https://api.github.com/search/repositories?q={query}{&page,per_page,sort,order}
 
 JSON response:
 "items": [
    {
    .
    .
    .
    }
 ]
 */

import Foundation

struct RepositoriesResponse: Codable, Equatable {
    let items: [Item]
}
