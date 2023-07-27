//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func postLogin(query: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol
    
    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func postLogin(query: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) {
        loginAPI.postLogin(query: query, completion: completion)
    }
}
