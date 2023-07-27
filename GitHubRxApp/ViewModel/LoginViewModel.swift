//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func getAuthPageURL(with url: URL)
    func didEnd()
}

protocol LoginViewModelProtocol {
    func didSelectLoginButton()
    func getAuthPageURL() -> URL?
    func didDisappearViewController()
}

class LoginViewModel: LoginViewModelProtocol {
    
    enum OAuthError: Error {
        case malformedLink
        case exchangeFailed
    }
    
    weak var delegate: LoginViewModelDelegate?
    
    private let loginRepository: LoginRepositoryProtocol // OAuthClient
    private var state: String?
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
    }
    
    deinit {
        print("deinit LoginViewModel")
    }
}

// MARK: LoginViewModelDelegate necessary methods
extension LoginViewModel {
    func didSelectLoginButton() {
        guard let url = getAuthPageURL() else { return }
        delegate?.getAuthPageURL(with: url)
    }
    
    internal func getAuthPageURL() -> URL? {
        state = UUID().uuidString
        // let urlString = "https://github.com/login/oauth/authorize?client_id=yourClientId&redirect_uri=com.beer.GitHubRxApp://authentication&s&scopes=repo,user&state=\(state)"
        // return URL(string: urlString)!
        return loginRepository.getAuthPageURL(state: state ?? "")
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
}

// MARK: Helper private methods
extension LoginViewModel {
    
}
