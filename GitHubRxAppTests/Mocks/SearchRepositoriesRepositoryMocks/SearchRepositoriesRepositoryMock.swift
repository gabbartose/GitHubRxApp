//
//  SearchRepositoriesRepositoryMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesRepositoryMock: SearchRepositoriesRepositoryProtocol {
    var getRepositoriesWasCalled = false
    var getRepositoriesCounter = 0

    var query: String?
    var page: Int?
    var perPage: Int?
    var sort: String?

    var errorReport: ErrorReport?
    var searchRepositoriesRepositoryResponse = RepositoriesResponse(items: [Item(id: 2,
                                                                                 name: "Repository",
                                                                                 owner: Owner(id: 2,
                                                                                              nodeId: "o4m_?m3399",
                                                                                              avatarUrl: "https://static.eau-thermale-avene.com/sites/files-hr/styles/380x460/public/images/product/image/hydrance-uv-lagana-hidrirajuca-emulzija-spf-30.png?itok=Il2AvOB7",
                                                                                              login: "tetris",
                                                                                              type: "Admin",
                                                                                              siteAdmin: true,
                                                                                              htmlUrl: "https://github.com/ZeusWPI/hydra-iOS"),
                                                                                 watchersCount: 10,
                                                                                 forksCount: 27,
                                                                                 stargazersCount: 5,
                                                                                 openIssues: 0,
                                                                                 language: "JAVA",
                                                                                 createdAt: "27.01.2000.",
                                                                                 updatedAt: "27.01.2000.",
                                                                                 htmlUrl: "https://github.com/ZeusWPI/hydra-iOS",
                                                                                 description: "Very nice description.")])

    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> Void) {
        getRepositoriesWasCalled = true
        getRepositoriesCounter += 1

        self.query = query
        self.page = page
        self.perPage = perPage
        self.sort = sort

        guard let errorReport = errorReport else {
            completion(.success(searchRepositoriesRepositoryResponse))
            return
        }

        completion(.failure(errorReport))
    }
}
