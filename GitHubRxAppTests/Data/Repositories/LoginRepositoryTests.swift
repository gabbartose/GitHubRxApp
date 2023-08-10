//
//  LoginRepositoryTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 10.08.2023..
//

@testable import GitHubRxApp
import XCTest

final class LoginRepositoryTests: XCTestCase {
    
    private var loginAPIMock: LoginAPIMock!
    private var loginResponseMock: LoginResponseMock!
    private var sut: LoginRepository!
    
    override func setUpWithError() throws {
        loginAPIMock = LoginAPIMock()
        loginResponseMock = LoginResponseMock()
        sut = LoginRepository(networkManager: NetworkManager(), loginAPI: loginAPIMock)
    }

    override func tearDownWithError() throws {
        loginAPIMock = nil
        loginResponseMock = nil
        sut = nil
    }
}

// MARK: createSignInURLWithClientId() -> URL? tests
extension LoginRepositoryTests {
    
}

// MARK: codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> ()) tests
extension LoginRepositoryTests {
    
}

// MARK: getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> ()) tests
extension LoginRepositoryTests {
    
}
