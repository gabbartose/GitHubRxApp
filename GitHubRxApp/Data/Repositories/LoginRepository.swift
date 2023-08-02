//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func createSignInURLWithClientId() -> URL?
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ())
    func codeExchange(code: String, completion: @escaping (Result<String, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol

    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func createSignInURLWithClientId() -> URL? {
        loginAPI.createSignInURLWithClientId()
    }
    
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        loginAPI.getUser(completion: completion)
    }
    
    func codeExchange(code: String, completion: @escaping (Result<String, ErrorReport>) -> ()) {
        loginAPI.codeExchange(code: code, completion: completion)
    }
}
