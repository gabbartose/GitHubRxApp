//
//  SearchRepositoriesResponseMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesResponseMock {
    var id: Int? = 2
    var name: String? = "new name"
    var owner: Owner? = nil
    var watchersCount: Int? = 200
    var forksCount: Int? = 300
    var stargazersCount: Int? = 5
    var openIssues: Int? = 0
    var language: String? = "C#"
    var createdAt: String? = "02.02.2002."
    var updatedAt: String? = "15.03.2010."
    var htmlUrl: String? = "https://github.com/ZeusWPI/hydra-iOS"
    var description: String? = "This is very nice description"
    
    var ownerId: Int? = 3
    var nodeId: String? = "MDEyOk9yZ2FuaXphdGlvbjMzMTc1MA=="
    var avatarUrl: String? = "https://avatars.githubusercontent.com/u/331750?v=4"
    var login: String? = "ZeusWPI"
    var type: String? = "Organization"
    var siteAdmin: Bool? = false
    var ownerHtmlUrl: String? = "https://github.com/ZeusWPI"
    
    func getRepositoriesResponse() -> RepositoriesResponse {
        let owner = Owner(id: ownerId,
                          nodeId: nodeId,
                          avatarUrl: avatarUrl,
                          login: login,
                          type: type,
                          siteAdmin: siteAdmin,
                          htmlUrl: ownerHtmlUrl)

        let items = [Item(id: id,
                          name: name,
                          owner: owner,
                          watchersCount: watchersCount,
                          forksCount: forksCount,
                          stargazersCount: stargazersCount,
                          openIssues: openIssues,
                          language: language,
                          createdAt: createdAt,
                          updatedAt: updatedAt,
                          htmlUrl: htmlUrl,
                          description: description)]
        return RepositoriesResponse(items: items)
    }

    func getRepositories() -> [Item] {
        [Item(id: id,
              name: name,
              owner: owner,
              watchersCount: watchersCount,
              forksCount: forksCount,
              stargazersCount: stargazersCount,
              openIssues: openIssues,
              language: language,
              createdAt: createdAt,
              updatedAt: updatedAt,
              htmlUrl: htmlUrl,
              description: description)]
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
