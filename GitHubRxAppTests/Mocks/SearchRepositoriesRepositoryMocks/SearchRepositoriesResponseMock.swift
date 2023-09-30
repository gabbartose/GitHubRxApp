//
//  SearchRepositoriesResponseMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesResponseMock {
    // Item details
    private var id: Int? = 2
    private var name: String? = "C# organization"
    private var watchersCount: Int? = 200
    private var forksCount: Int? = 300
    private var stargazersCount: Int? = 5
    private var openIssues: Int? = 0
    private var language: String? = "C#"
    private var createdAt: String? = "2019-09-10T19:23:58Z"
    private var updatedAt: String? = "2023-08-04T05:07:52Z"
    private var htmlUrl: String? = "https://github.com/ZeusWPI/hydra-iOS"
    private var description: String? = "This is very nice description"

    // Owner details
    private var ownerId: Int? = 3
    private var nodeId: String? = "MDEyOk9yZ2FuaXphdGlvbjMzMTc1MA=="
    private var avatarUrl: String? = "https://avatars.githubusercontent.com/u/331750?v=4"
    private var login: String? = "ZeusWPI"
    private var type: String? = "Organization"
    private var siteAdmin: Bool? = false
    private var ownerHtmlUrl: String? = "https://github.com/ZeusWPI"

    func getOwnerItem() -> Owner {
        let owner = Owner(id: ownerId,
                          nodeId: nodeId,
                          avatarUrl: avatarUrl,
                          login: login,
                          type: type,
                          siteAdmin: siteAdmin,
                          htmlUrl: ownerHtmlUrl)
        return owner
    }

    func getRepositoryItem() -> Item {
        let repositoryItem = Item(id: id,
                                  name: name,
                                  owner: getOwnerItem(),
                                  watchersCount: watchersCount,
                                  forksCount: forksCount,
                                  stargazersCount: stargazersCount,
                                  openIssues: openIssues,
                                  language: language,
                                  createdAt: createdAt,
                                  updatedAt: updatedAt,
                                  htmlUrl: htmlUrl,
                                  description: description)
        return repositoryItem
    }

    func getRepositoriesResponse() -> RepositoriesResponse {
        let items = [getRepositoryItem()]
        return RepositoriesResponse(items: items)
    }

    func getJsonString() -> String {
          """
          {
            "items": [
                {
                    "id": \(id ?? 0),
                    "name": "\(name ?? "")",
                    "owner": {
                                "login": "\(login ?? "")",
                                "id": \(ownerId ?? 0),
                                "node_id": "\(nodeId ?? "")",
                                "avatar_url": "\(avatarUrl ?? "")",
                                "html_url": "\(ownerHtmlUrl ?? "")",
                                "type": "\(type ?? "")",
                                "site_admin": \(siteAdmin ?? false)
                             },
                    "html_url": "\(htmlUrl ?? "")",
                    "description": "\(description ?? "")",
                    "created_at": "\(createdAt ?? "")",
                    "updated_at": "\(updatedAt ?? "")",
                    "watchers_count": \(watchersCount ?? 0),
                    "language": "\(language ?? "")",
                    "forks_count": \(forksCount ?? 0),
                    "stargazers_count": \(stargazersCount ?? 0),
                    "open_issues": \(openIssues ?? 0)
                }
                    ]
          }
          """
    }
}
