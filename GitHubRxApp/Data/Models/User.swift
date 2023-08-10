//
//  User.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 28.07.2023..
//

// GitHub API info:
/*
 // URL: https://api.github.com/user
 
 JSON response:
 {
   "message": "Requires authentication",
   "documentation_url": "https://docs.github.com/rest/users/users#get-the-authenticated-user"
 }
 */

import Foundation

struct User: Codable, Equatable {
    var login: String
    var name: String
}
