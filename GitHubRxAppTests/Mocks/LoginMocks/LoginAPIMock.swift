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
    var signInURL: URL?
    
    var codeExchangeWasCalled = false
    var codeExchangeCounter = 0
    var codeExchangeResponse: HTTPURLResponse?
    var codeExchangeObject: String?
    var code: String?
    
    var getUserWasCalled = false
    var getUserCounter = 0
    var getUserResponse: HTTPURLResponse?
    var getUserObject: User?
    
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
        getUserWasCalled = true
        getUserCounter += 1
        
        guard let getUserResponse = getUserResponse,
              let getUserObject = getUserObject else {
            completion(.failure(ErrorReport(cause: .other, data: nil)))
            return
        }
        completion(.success((getUserResponse, object: getUserObject)))
    }
}
