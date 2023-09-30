//
//  LoginAPI.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 02.08.2023..
//

import Foundation

protocol LoginAPIProtocol {
    func createSignInURLWithClientId() -> URL?
    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> Void)
    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> Void)
}

final class LoginAPI: LoginAPIProtocol {
    private enum Paths: String, Equatable {
        case signIn = "/login/oauth/authorize"
        case codeExchange = "/login/oauth/access_token"
        case getUser = "/user"
    }

    private let clientID = Bundle.main.object(forInfoDictionaryKey: "ClientID") as? String
    private let clientSecret = Bundle.main.object(forInfoDictionaryKey: "ClientSecret") as? String
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
}

extension LoginAPI {
    func createSignInURLWithClientId() -> URL? {
        var resource = Resource<String>(path: Paths.signIn.rawValue)

        resource.queryItems = [
            URLQueryItem(name: "client_id", value: clientID)
        ]

        return networkManager.createEndpoint(for: resource, basePath: networkManager.configuration.oAuthBasePath)
    }

    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> Void) {
        var resource = Resource<String>(path: Paths.codeExchange.rawValue, method: .post)

        resource.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "client_secret", value: clientSecret),
            URLQueryItem(name: "code", value: code)
        ]

        networkManager.apiOAuthCall(for: resource, basePath: .oAuthBasePath, completion: completion)
    }

    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> Void) {
        let resource = Resource<User>(path: Paths.getUser.rawValue)
        networkManager.apiOAuthCall(for: resource, basePath: .basePath, completion: completion)
    }
}
