//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    var signInPath: String { get }
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ())
    
    func signInPathWithClientId() -> URL
}

class LoginRepository: LoginRepositoryProtocol {
    
    var signInPath: String {
        return loginAPI.signInPath
    }
    
    let loginAPI: LoginAPIProtocol
    
    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        loginAPI.signInUser(completion: completion)
    }
    
    func signInPathWithClientId() -> URL {
        loginAPI.signInPathWithClientId()
    }
}
