//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginAPIProtocol {
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ())
}

class LoginAPI: LoginAPIProtocol {
    
    
    
    private enum Paths: String {
        case tokenPath = "/search/nesto"
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ()) {
        var resource = Resource<TokenBag>(path: Paths.tokenPath.rawValue)
        resource.queryItems = [
            // URLQueryItem(name: "q", value: query)
        ]
        
        networkManager.apiCall(for: resource, completion: completion)
    }
}
