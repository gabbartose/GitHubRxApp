//
//  Owner.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

// GitHub API info:
/*
 // URL: https://api.github.com/search/repositories?q={query}{&page,per_page,sort,order}
 
 JSON response:
 "owner": {
        "login": "TanStack",
        "id": 72518640,
        "node_id": "MDEyOk9yZ2FuaXphdGlvbjcyNTE4NjQw",
        "avatar_url": "https://avatars.githubusercontent.com/u/72518640?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/TanStack",
        "html_url": "https://github.com/TanStack",
        "followers_url": "https://api.github.com/users/TanStack/followers",
        "following_url": "https://api.github.com/users/TanStack/following{/other_user}",
        "gists_url": "https://api.github.com/users/TanStack/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/TanStack/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/TanStack/subscriptions",
        "organizations_url": "https://api.github.com/users/TanStack/orgs",
        "repos_url": "https://api.github.com/users/TanStack/repos",
        "events_url": "https://api.github.com/users/TanStack/events{/privacy}",
        "received_events_url": "https://api.github.com/users/TanStack/received_events",
        "type": "Organization",
        "site_admin": false
       }
 */

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
