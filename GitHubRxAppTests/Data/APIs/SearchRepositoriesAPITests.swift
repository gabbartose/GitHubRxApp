//
//  SearchRepositoriesAPITests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

@testable import GitHubRxApp
import XCTest

final class SearchRepositoriesAPITests: XCTestCase {
    
    private var sut: SearchRepositoriesAPI!
    private var urlSessionMock: URLSessionMock!
    private var searchRepositoriesResponseMock: SearchRepositoriesResponseMock!

    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        sut = SearchRepositoriesAPI(networkManager: NetworkManager(configuration: NetworkConfiguration(session: urlSessionMock)))
        searchRepositoriesResponseMock = SearchRepositoriesResponseMock()
    }

    override func tearDownWithError() throws {
        urlSessionMock = nil
        sut = nil
        searchRepositoriesResponseMock = nil
    }

}

// MARK: getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<(response: HTTPURLResponse, object: RepositoriesResponse), ErrorReport>) -> ()) tests
extension SearchRepositoriesAPITests {
    func testSearchRepositoriesAPI_WhenGetRepositoriesCalledOnSuccess_ShouldCallCompletionWithRepositoriesResponse() {
        // Given
        let query = "iOS"
        let page = 1
        let perPage = 20
        let sort = "forks"
        
        let jsonString = searchRepositoriesResponseMock.getJsonString()
        let excpectedRepositories = searchRepositoriesResponseMock.getRepositoriesResponse()
        
        urlSessionMock.data = jsonString.data(using: .utf8)
        
        let completionExpectation = expectation(description: "Completion block expectation")
        let completion: (Result<(response: HTTPURLResponse, object: RepositoriesResponse), ErrorReport>) -> () = { result in
//            guard case .success(let repositoriesResponse, nesto) = result, repositoriesResponse == excpectedRepositories else { return }
//            completionExpectation.fulfill()
        }
        
        // When
        sut.getRepositories(query: query, page: page, perPage: perPage, sort: sort, completion: completion)
        
        // Then
        wait(for: [completionExpectation], timeout: 5)
    }
    
}
