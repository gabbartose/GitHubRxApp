//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
//    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ())
//    func codeExcanhange(code: String, completion: @escaping (Result<String, ErrorReport>) -> ())
    
    func createSignInURLWithClientId() -> URL?
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol

    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
//    func signInUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
//        loginAPI.signInUser(completion: completion)
//    }

//    func codeExcanhange(code: String, completion: @escaping (Result<String, ErrorReport>) -> ()) {
//        loginAPI.codeExcanhange(code: code, completion: completion)
//    }
    
    func createSignInURLWithClientId() -> URL? {
        loginAPI.createSignInURLWithClientId()
    }
    
    func getUser(completion: @escaping (Result<User, ErrorReport>) -> ()) {
        loginAPI.getUser(completion: completion)
    }
}
