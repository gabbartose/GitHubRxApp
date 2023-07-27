//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginAPIProtocol {
    func postLogin(query: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ())
}

class LoginAPI: LoginAPIProtocol {
    
    private enum Paths: String {
        case searchRepositories = "/search/nesto"
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
    func postLogin(query: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        var resource = Resource<RepositoriesResponse>(path: Paths.searchRepositories.rawValue)
        resource.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        
        networkManager.apiCall(for: resource, completion: completion)
    }
}
