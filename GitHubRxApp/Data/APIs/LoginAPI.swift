//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginAPIProtocol {
    var signInPath: String { get }
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ())
    func signInPathWithClientId() -> URL
}

class LoginAPI: LoginAPIProtocol {
    
    var signInPath: String = Paths.signIn.rawValue
    
    
    private enum Paths: String {
        case codeExchange = "/login/oauth/access_token"
        case getUser = "/user"
        case signIn = "/login/oauth/authorize"
    }
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
    
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        var resource = Resource<User>(path: Paths.signIn.rawValue)
        
        print(resource)
        
        resource.queryItems = [
            URLQueryItem(name: "client_id", value: NetworkManager.Constants.clientID)
        ]
        
        print(resource)
        
        networkManager.apiCall(for: resource, basePath: networkManager.configuration.oAuthBasePath, completion: completion)
    }
    
    
    func signInPathWithClientId() -> URL {
        var resource = Resource<User>(path: Paths.signIn.rawValue)
        resource.queryItems = [
            URLQueryItem(name: "client_id", value: NetworkManager.Constants.clientID)
        ]
        
        guard let signInURL = networkManager.createEndpoint(for: resource, basePath: networkManager.configuration.oAuthBasePath) else {
            fatalError("Could not create the Sign In URL.")
        }
        
        return signInURL
    }
}
