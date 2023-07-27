//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func openScreenInSafari(url: URL)
    func didEnd()
}

protocol LoginViewModelProtocol {
    func didSelectLoginButton()
    func didDisappearViewController()
}

class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginViewModelDelegate?
    
    init() {
        
    }
    
    deinit {
        print("deinit LoginViewModel")
    }
}

// MARK: LoginViewModelDelegate necessary methods
extension LoginViewModel {
    func didSelectLoginButton() {
        guard let url = getAuthPageURL() else { return }
        delegate?.openScreenInSafari(url: url)
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
}

// MARK: Helper private methods
extension LoginViewModel {
    private func getAuthPageURL() -> URL? {
        let state = UUID().uuidString
        let urlString = "https://github.com/login/oauth/authorize?client_id=yourClientId&redirect_uri=it.iacopo.github://authentication&s&scopes=repo,user&state=\(state)"
        return URL(string: urlString)!
    }
}
