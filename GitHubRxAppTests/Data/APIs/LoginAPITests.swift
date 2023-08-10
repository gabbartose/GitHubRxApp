//
//  LoginAPITests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 10.08.2023..
//

@testable import GitHubRxApp
import XCTest
import AuthenticationServices

final class LoginAPITests: XCTestCase {
    
    private var searchRepositoriesResponseMock: LoginResponseMock!
    private var loginAPIMock: LoginAPIMock!
    private var urlSessionMock: URLSessionMock!
    private var sut: LoginAPI!
    
    private let codeExchange = "f9647d7ed86168c85a5a"
    
    override func setUpWithError() throws {
        searchRepositoriesResponseMock = LoginResponseMock()
        loginAPIMock = LoginAPIMock()
        urlSessionMock = URLSessionMock()
        sut = LoginAPI(networkManager: NetworkManager(configuration: NetworkConfiguration(session: urlSessionMock)))
    }
    
    override func tearDownWithError() throws {
        searchRepositoriesResponseMock = nil
        loginAPIMock = nil
        urlSessionMock = nil
        sut = nil
    }
}

// MARK: createSignInURLWithClientId() -> URL? tests
extension LoginAPITests {
    // TODO: See what's going on with that test below
    /*
    func testLoginAPI_WhenCreateSignInURLWithClientIdCalledOnSuccess_ShouldCallCreateEndpointOnNetworkManager() {
        // Arrange (Given)
        let signIn = URL(string: "https://github.com/login/oauth/authorize?client_id=Iv1.03eda0e0b6c3100b") ?? URL(string: "")
        
        // Act (When)
        if let signInURL = sut.createSignInURLWithClientId() {
            // Assert (Then)
            XCTAssertEqual(loginAPIMock.signInURL, signIn)
        }
    }
     */
}

// MARK: codeExchange(code: String, completion: @escaping (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> ()) tests
extension LoginAPITests {
    func testLoginAPI_WhenCodeExchangeCalledOnSuccess_ShouldCallCompletionWithSuccessResponse() {
        // Arrange (Given)
        let returnedDictionaryJsonString = searchRepositoriesResponseMock.getReturnedDictionaryResponse()
        urlSessionMock.data = returnedDictionaryJsonString.data(using: .utf8)
        
        let completionExpectation = expectation(description: "Completion block expectation")
        let completion: (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> () = { result in
            guard case .success((_, let returnedObject)) = result, returnedObject == "Success" else { return }
            completionExpectation.fulfill()
        }

        // Act (When)
        sut.codeExchange(code: codeExchange, completion: completion)
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
    
    func testLoginAPI_WhenCodeExchangeCalledOnFailure_ShouldCallCompletionWithErrorReport() {
        // Arrange (Given)
        urlSessionMock.errorCode = 404
        
        let completionExpectation = expectation(description: "Completion block expectation")
        let completion: (Result<(response: HTTPURLResponse, object: String), ErrorReport>) -> () = { result in
            guard case .failure(let errorReport) = result, errorReport.cause == .dataMissing else { return }
            completionExpectation.fulfill()
        }
        
        // Act (When)
        sut.codeExchange(code: codeExchange, completion: completion)
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
}

// MARK: getUser(completion: @escaping (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> ()) tests
extension LoginAPITests {
    func testLoginAPI_WhenGetUserCalledOnSuccess_ShouldCallCompletionWithUserSuccessResponse() {
        // Arrange (Given)
        let userResponseJsonString = searchRepositoriesResponseMock.getUserResponseJsonString()
        let excpectedUser = searchRepositoriesResponseMock.getUserResponse()
        
        urlSessionMock.data = userResponseJsonString.data(using: .utf8)
        
        let completionExpectation = expectation(description: "Completion block expectation")
        let completion: (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> () = { result in
            guard case .success((_, let object)) = result, object == excpectedUser else { return }
            completionExpectation.fulfill()
        }
        
        // Act (When)
        sut.getUser(completion: completion)
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
    
    func testLoginAPI_WhenGetUserCalledOnFailure_ShouldCallCompletionWithErrorReport() {
        // Arrange (Given)
        urlSessionMock.errorCode = 404
        
        let completionExpectation = expectation(description: "Completion block expectation")
        let completion: (Result<(response: HTTPURLResponse, object: User), ErrorReport>) -> () = { result in
            guard case .failure(let errorReport) = result, errorReport.cause == .dataMissing else { return }
            completionExpectation.fulfill()
        }
        
        // Act (When)
        sut.getUser(completion: completion)
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
}
