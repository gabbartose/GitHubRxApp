//
//  SearchRepositoriesRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import Foundation

protocol SearchRepositoriesRepositoryProtocol {
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ())
}

final class SearchRepositoriesRepository: SearchRepositoriesRepositoryProtocol {
    
    let searchRepositoriesAPI: SearchRepositoriesAPIProtocol
    
    init(networkManager: NetworkManager, searchRepositoriesAPI: SearchRepositoriesAPIProtocol? = nil) {
        self.searchRepositoriesAPI = searchRepositoriesAPI ?? SearchRepositoriesAPI(networkManager: networkManager)
    }
}

extension SearchRepositoriesRepository {
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        searchRepositoriesAPI.getRepositories(query: query, page: page, perPage: perPage, sort: sort, completion: completion)
    }
}
