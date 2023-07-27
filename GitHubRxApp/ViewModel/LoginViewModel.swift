//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func didEnd()
}

protocol LoginViewModelProtocol {
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

extension LoginViewModel {
    func didDisappearViewController() {
        
    }
}
