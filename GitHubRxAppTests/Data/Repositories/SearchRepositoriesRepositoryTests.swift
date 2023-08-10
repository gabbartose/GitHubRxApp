//
//  SearchRepositoriesRepositoryTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 08.08.2023..
//

@testable import GitHubRxApp
import XCTest

final class SearchRepositoriesRepositoryTests: XCTestCase {

    private var searchRepositoriesAPIMock: SearchRepositoriesAPIMock!
    private var repositoriesResponseMock: SearchRepositoriesResponseMock!
    private var sut: SearchRepositoriesRepository!
    
    private let query = "iOS"
    private let page = 1
    private let perPage = 20
    private let sort = "forks"
    
    override func setUpWithError() throws {
        searchRepositoriesAPIMock = SearchRepositoriesAPIMock()
        repositoriesResponseMock = SearchRepositoriesResponseMock()
        sut = SearchRepositoriesRepository(networkManager: NetworkManager(), searchRepositoriesAPI: searchRepositoriesAPIMock)
    }

    override func tearDownWithError() throws {
        searchRepositoriesAPIMock = nil
        repositoriesResponseMock = nil
        sut = nil
    }
}

// MARK: getRepositories(query: String, page: Int, perPage: Int, sort: String, completion: @escaping (Result<RepositoriesResponse, ErrorReport>) -> ()) tests
extension SearchRepositoriesRepositoryTests {
    func testSearchRepositoriesRepository_WhenGetRepositoryMethodCalled_ShouldCallRepositoriesAPIGetRepositoriesMethod() {
        // Arrange (Given)
        let completion: (Result<RepositoriesResponse, ErrorReport>) -> () = { _ in }
        
        // Act (When)
        sut.getRepositories(query: query, page: page, perPage: perPage, sort: sort, completion: completion)
        
        // Assert (Then)
        XCTAssertTrue(searchRepositoriesAPIMock.getSearchRepositoriesRepositoryCalled)
        XCTAssertEqual(searchRepositoriesAPIMock.getSearchRepositoriesRepositoryCounter, 1)
        XCTAssertEqual(searchRepositoriesAPIMock.query, query)
        XCTAssertEqual(searchRepositoriesAPIMock.page, page)
        XCTAssertEqual(searchRepositoriesAPIMock.perPage, perPage)
        XCTAssertEqual(searchRepositoriesAPIMock.sort, sort)
    }
    
    func testSearchRepositoriesRepository_WhenGetRepositoriesMethodCalledOnSuccess_ShouldCallCompletionWithRepositories() {
        // Arrange (Given)
        let searchRepositoriesRepositoryResponse = repositoriesResponseMock.getRepositoriesResponse()
        searchRepositoriesAPIMock.searchRepositoriesRepositoryResponse = searchRepositoriesRepositoryResponse
        let completionExpectation = expectation(description: "Completion block expectation")
        
        // Act (When)
        sut.getRepositories(query: query, page: page, perPage: perPage, sort: sort) { result in
            guard case .success = result else { return }
            completionExpectation.fulfill()
        }
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
    
    func testSearchRepositoriesRepository_WhenGetRepositoriesMethodCalledOnFailure_ShouldCallCompletionWithErrorReport() {
        // Arrange (Given)
        let completionExpectation = expectation(description: "Completion block expectation")
        
        // Act (When)
        sut.getRepositories(query: query, page: page, perPage: perPage, sort: sort) { result in
            guard case .failure = result else { return }
            completionExpectation.fulfill()
        }
        
        // Assert (Then)
        wait(for: [completionExpectation], timeout: 5)
    }
}
