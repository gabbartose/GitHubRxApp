//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol
    
    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ()) {
        loginAPI.exchangeCodeForToken(code: code, state: state, completion: completion)
    }
}
