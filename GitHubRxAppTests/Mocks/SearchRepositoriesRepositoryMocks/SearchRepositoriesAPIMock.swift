//
//  SearchRepositoriesAPIMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesAPIMock: SearchRepositoriesAPIProtocol {
    
    var getSearchRepositoriesRepositoryCalled = false
    var getSearchRepositoriesRepositoryCounter = 0
    var searchRepositoriesRepositoryResponse: RepositoriesResponse?
    var query: String?
    var page: Int?
    var perPage: Int?
    var sort: String?
    
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        getSearchRepositoriesRepositoryCalled = true
        getSearchRepositoriesRepositoryCounter += 1
        self.query = query
        self.page = page
        self.perPage = perPage
        self.sort = sort
        
        guard let searchRepositoriesRepositoryResponse = searchRepositoriesRepositoryResponse else {
            completion(.failure(ErrorReport(cause: .other, data: nil)))
            return
        }
        completion(.success(searchRepositoriesRepositoryResponse))
    }
    
    
}
