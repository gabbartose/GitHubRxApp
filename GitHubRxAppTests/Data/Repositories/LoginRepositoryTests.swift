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
    
    private let codeExchange = "f9647d7ed86168c85a5a"
    
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
    func testLoginRepository_WhenCodeExchangeMethodCalled_ShouldCallLoginAPICodeExchangeMethod() {
        // Arrange (Given)
        let completion: (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> () = { _ in }
        
        // Act (When)
        sut.codeExchange(code: codeExchange, completion: completion)
        
        // Assert (Then)
        XCTAssertTrue(loginAPIMock.codeExchangeWasCalled)
        XCTAssertEqual(loginAPIMock.codeExchangeCounter, 1)
        XCTAssertEqual(loginAPIMock.code, codeExchange)
    }
    
    func testLoginRepository_WhenCodeExchangeMethodCalledOnSuccess_ShouldCallCompletionWithSuccess() {
        // Arrange (Given)
        let codeExchangeURL = loginResponseMock.codeExchangeURL
        let codeExchangeResponse = HTTPURLResponse(url: codeExchangeURL!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let codeExchangeObject = loginResponseMock.getSuccessStringResponse()
        
        loginAPIMock.codeExchangeResponse = codeExchangeResponse
        loginAPIMock.codeExchangeObject = codeExchangeObject
        
        let completionExpectation = expectation(description: "Completion block expectation")
        
        // Act (When)
        sut.codeExchange(code: codeExchange) { result in
            guard case .success = result else { return }
            completionExpectation.fulfill()
        }
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
    
    func testLoginRepository_WhenCodeExchangeMethodCalledOnFailure_ShouldCallCompletionWithErrorReport() {
        // Arrange (Given)
        let completionExpectation = expectation(description: "Completion block expectation")
        
        // Act (When)
        sut.codeExchange(code: codeExchange) { result in
            guard case .failure = result else { return }
            completionExpectation.fulfill()
        }
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
}

// MARK: getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> ()) tests
extension LoginRepositoryTests {
    
}
