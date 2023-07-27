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

class SearchRepositoriesRepository: SearchRepositoriesRepositoryProtocol {
    
    let repositoriesAPI: RepositoriesAPIProtocol
    
    init(networkManager: NetworkManager, repositoriesAPI: RepositoriesAPIProtocol? = nil) {
        self.repositoriesAPI = repositoriesAPI ?? RepositoriesAPI(networkManager: networkManager)
    }
}

extension SearchRepositoriesRepository {
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        repositoriesAPI.getRepositories(query: query, page: page, perPage: perPage, sort: sort, completion: completion)
    }
}
