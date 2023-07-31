//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol
    
    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        loginAPI.signInUser(completion: completion)
    }
}
