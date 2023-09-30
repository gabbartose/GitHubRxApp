//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func createSignInURLWithClientId() -> URL?
    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> Void)
    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> Void)
}

final class LoginRepository: LoginRepositoryProtocol {
    let loginAPI: LoginAPIProtocol

    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func createSignInURLWithClientId() -> URL? {
        loginAPI.createSignInURLWithClientId()
    }

    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> Void) {
        loginAPI.codeExchange(code: code, completion: completion)
    }

    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> Void) {
        loginAPI.getUser(completion: completion)
    }
}
