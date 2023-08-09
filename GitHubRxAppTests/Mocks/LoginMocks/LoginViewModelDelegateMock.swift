//
//  LoginViewModelDelegateMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class LoginViewModelDelegateMock: LoginViewModelDelegate {
    
    var showSearchRepositoriesScreenWasCalled = false
    var showSearchRepositoriesScreenCounter = 0
    
    var didEndWasCalled = false
    var didEndCounter = 0
    
    func showSearchRepositoriesScreen() {
        showSearchRepositoriesScreenWasCalled = true
        showSearchRepositoriesScreenCounter += 1
    }
    
    func didEnd() {
        didEndWasCalled = true
        didEndCounter += 1
    }
}
