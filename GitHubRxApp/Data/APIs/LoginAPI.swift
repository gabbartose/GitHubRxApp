//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 02.08.2023..
//

import Foundation

protocol LoginAPIProtocol {
    func createSignInURLWithClientId() -> URL?
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ())
}

class LoginAPI: LoginAPIProtocol {
    
    private enum Paths: String {
        case signIn = "/login/oauth/authorize"
        case getUser = "/user"
    }
    
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
    func createSignInURLWithClientId() -> URL? {
        var resource = Resource<String>(path: Paths.signIn.rawValue)
        
        resource.queryItems = [
            URLQueryItem(name: "client_id", value: networkManager.clientID)
        ]
        
        return networkManager.createEndpoint(for: resource, basePath: networkManager.configuration.oAuthBasePath)
    }
    
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        var resource = Resource<User>(path: Paths.getUser.rawValue)
        networkManager.apiCall(for: resource, basePath: .oAuthBasePath, completion: completion)
    }
}
