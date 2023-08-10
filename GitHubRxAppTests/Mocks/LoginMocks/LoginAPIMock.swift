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
    
    var codeExchangeWasCalled = false
    var codeExchangeCounter = 0
    var codeExchangeResponse: HTTPURLResponse?
    var codeExchangeObject: String?
    var code: String?
    
    func createSignInURLWithClientId() -> URL? {
        createSignInURLWithClientIdWasCalled = true
        createSignInURLWithClientIdCounter += 1
        return signInURL
    }
    
    func codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> ()) {
        codeExchangeWasCalled = true
        codeExchangeCounter += 1
        self.code = code
        
        guard let codeExchangeResponse = codeExchangeResponse,
        let codeExchangeObject = codeExchangeObject else {
            completion(.failure(ErrorReport(cause: .other, data: nil)))
            return
        }
        completion(.success((codeExchangeResponse, object: codeExchangeObject)))
    }
    
    func getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> ()) {
        
        // response za user-a
        // Object: User(login: Optional("gabbartose"), name: Optional("Gabrijel Bartošek"))

    }
}
