//
//  SearchRepositoriesResponseMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesResponseMock {
    private var id: Int? = 2
    private var name: String? = "new name"
    private var owner: Owner? = nil
    private var watchersCount: Int? = 200
    private var forksCount: Int? = 300
    private var stargazersCount: Int? = 5
    private var openIssues: Int? = 0
    private var language: String? = "C#"
    private var createdAt: String? = "02.02.2002."
    private var updatedAt: String? = "15.03.2010."
    private var htmlUrl: String? = "https://github.com/ZeusWPI/hydra-iOS"
    private var description: String? = "This is very nice description"

    private var ownerId: Int? = 3
    private var nodeId: String? = "MDEyOk9yZ2FuaXphdGlvbjMzMTc1MA=="
    private var avatarUrl: String? = "https://avatars.githubusercontent.com/u/331750?v=4"
    private var login: String? = "ZeusWPI"
    private var type: String? = "Organization"
    private var siteAdmin: Bool? = false
    private var ownerHtmlUrl: String? = "https://github.com/ZeusWPI"
    
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
    
    func getOwnerItem() -> Owner {
        let owner = Owner(id: 2,
                          nodeId: "o4m_?m3399",
                          avatarUrl: "https://static.eau-thermale-avene.com/sites/files-hr/styles/380x460/public/images/product/image/hydrance-uv-lagana-hidrirajuca-emulzija-spf-30.png?itok=Il2AvOB7",
                          login: "tetris",
                          type: "Admin",
                          siteAdmin: true,
                          htmlUrl: "https://github.com/ZeusWPI/hydra-iOS")
        return owner
    }
    
    func getRepositoryItem() -> Item {
        let owner = Owner(id: 2,
                          nodeId: "o4m_?m3399",
                          avatarUrl: "https://static.eau-thermale-avene.com/sites/files-hr/styles/380x460/public/images/product/image/hydrance-uv-lagana-hidrirajuca-emulzija-spf-30.png?itok=Il2AvOB7",
                          login: "tetris",
                          type: "Admin",
                          siteAdmin: true,
                          htmlUrl: "https://github.com/ZeusWPI/hydra-iOS")
        
        let repositoryItem = Item(id: 2,
                                  name: "Repository",
                                  owner: getOwnerItem(),
                                  watchersCount: 10,
                                  forksCount: 27,
                                  stargazersCount: 5,
                                  openIssues: 0,
                                  language: "JAVA",
                                  createdAt: "27.01.2000.",
                                  updatedAt: "27.01.2000.",
                                  htmlUrl: "https://github.com/ZeusWPI/hydra-iOS",
                                  description: "Very nice description.")
        return repositoryItem
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
