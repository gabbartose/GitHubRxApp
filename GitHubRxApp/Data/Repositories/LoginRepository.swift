//
//  LoginRepository.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginRepositoryProtocol {
    func getAuthPageURL(state: String) -> URL?
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ())
}

class LoginRepository: LoginRepositoryProtocol {
    
    let loginAPI: LoginAPIProtocol
    
    init(networkManager: NetworkManager, loginAPI: LoginAPIProtocol? = nil) {
        self.loginAPI = loginAPI ?? LoginAPI(networkManager: networkManager)
    }
}

extension LoginRepository {
    func getAuthPageURL(state: String) -> URL? {
        let urlString = "https://github.com/login/oauth/authorize?client_id=yourClientId&redirect_uri=com.beer.GitHubRxApp://authentication&s&scopes=repo,user&state=\(state)"
        return URL(string: urlString)!
    }
    
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, ErrorReport>) -> ()) {
        loginAPI.exchangeCodeForToken(code: code, state: state, completion: completion)
    }
}
