//
//  SearchRepositoriesAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import Foundation

protocol SearchRepositoriesAPIProtocol {
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ())
}

class SearchRepositoriesAPI: SearchRepositoriesAPIProtocol {
    
    private enum Paths: String {
        case searchRepositories = "/search/repositories"
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension SearchRepositoriesAPI {
    func getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        var resource = Resource<RepositoriesResponse>(path: Paths.searchRepositories.rawValue)
        resource.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "sort", value: "\(sort)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        
        print("Repositories: \(resource)")
        
        networkManager.apiCall(for: resource, basePath: networkManager.configuration.basePath, completion: completion)
    }
}
