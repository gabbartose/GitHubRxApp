//
//  LoginAPIMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 10.08.2023..
//

import Foundation
@testable import GitHubRxApp

class LoginAPIMock: LoginAPIProtocol {
    
    var createSignInURLWithClientIdWasCalled = false
    var createSignInURLWithClientIdCounter = 0
    var signInURL: URL? = URL(string: "https://github.com/login/oauth/authorize?client_id=Iv1.03eda0e0b6c3100b") ?? URL(string: "")
    
    func createSignInURLWithClientId() -> URL? {
        createSignInURLWithClientIdWasCalled = true
        createSignInURLWithClientIdCounter += 1
        return signInURL
    }
    
    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> ()) {
        
    }
    
    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> ()) {
        
    }
    
    
}
