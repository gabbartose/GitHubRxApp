//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginAPIProtocol {
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ())
}

class LoginAPI: LoginAPIProtocol {
    
    struct Constants {
        static let callbackURLScheme = "com.beer.GitHubRxApp"
        static let clientID = "Iv1.03eda0e0b6c3100b"
        static let clientSecret = "370d1b2a85339484e0bb76c26a214ffbac09a388"
    }
    
    private enum Paths {
        case codeExchange
        case getUser
        case signIn
        
        var path: String {
            switch self {
            case .codeExchange:
                return "/login/oauth/access_token"
            case .getUser:
                return "/user"
            case .signIn:
                return "/login/oauth/authorize"
            }
        }
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
//    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ()) {
//        var resource = Resource<TokenBag>(path: Paths.getRepos(username).path)
//        resource.queryItems = [
//            // URLQueryItem(name: "q", value: query)
//        ]
//        
//        networkManager.apiCall(for: resource, completion: completion)
//    }
    
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        var resource = Resource<User>(path: Paths.signIn.path)
        networkManager.apiCall(for: resource, completion: completion)
    }
}

extension LoginAPI {
    
}
