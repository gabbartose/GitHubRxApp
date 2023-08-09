//
//  RepositoryDetailsViewModelTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

@testable import GitHubRxApp
import XCTest

final class RepositoryDetailsViewModelTests: XCTestCase {
    
    private var sut: RepositoryDetailsViewModel!
    private var searchRepositoriesResponseMock: SearchRepositoriesResponseMock!
    private var repositoryDetailsViewModelDelegateMock: RepositoryDetailsViewModelDelegateMock!
    
    override func setUpWithError() throws {
        repositoryDetailsViewModelDelegateMock = RepositoryDetailsViewModelDelegateMock()
        searchRepositoriesResponseMock = SearchRepositoriesResponseMock()
        sut = RepositoryDetailsViewModel(repositoryItem: searchRepositoriesResponseMock.getRepositoryItem())
        sut.delegate = repositoryDetailsViewModelDelegateMock
    }
    
    override func tearDownWithError() throws {
        repositoryDetailsViewModelDelegateMock = nil
        searchRepositoriesResponseMock = nil
        sut = nil
    }
}

// MARK: didSelectUserDetails(userDetails: Owner) test
extension RepositoryDetailsViewModelTests {
    func testRepositoryDetailsViewModel_WhenDidSelectUserDetailsCalled_ShouldCallDidSelectUserDetailsOnDelegate() {
        // Arrange (Given)
        
        // Act (When)
        sut.didSelectUserDetails(userDetails: searchRepositoriesResponseMock.getOwnerItem())
        
        // Assert (Then)
        XCTAssertTrue(repositoryDetailsViewModelDelegateMock.didSelectUserDetailsWasCalled)
        XCTAssertEqual(repositoryDetailsViewModelDelegateMock.didSelectUserDetailsWasCounter, 1)
    }
}

// MARK: didTapAdditionalInfoInBrowser(htmlURL: String) test
extension RepositoryDetailsViewModelTests {
    func testRepositoryDetailsViewModel_WhenDidTapAdditionalInfoInBrowserCalled_ShouldCallDidTapAdditionalInfoInBrowserOnDelegate() {
        // Arrange (Given)
        let htmlURLString = "https://github.com/nextcloud/ios"
        
        // Act (When)
        sut.didTapAdditionalInfoInBrowser(htmlURL: htmlURLString)
        
        // Assert (Then)
        XCTAssertTrue(repositoryDetailsViewModelDelegateMock.didTapAdditionalInfoInBrowserWasCalled)
        XCTAssertEqual(repositoryDetailsViewModelDelegateMock.didTapAdditionalInfoInBrowserCounter, 1)
        XCTAssertEqual(repositoryDetailsViewModelDelegateMock.htmlURL, htmlURLString)
    }
}

// MARK: didEnd() test
extension RepositoryDetailsViewModelTests {
    func testRepositoryDetailsViewModel_WhenDidDissapearWasCalled_ShouldCallDidEndOnDelegate() {
        // Arrange (Given)
        
        // Act (When)
        sut.didDisappearViewController()
        
        // Assert (Then)
        XCTAssertTrue(repositoryDetailsViewModelDelegateMock.didEndWasCalled)
        XCTAssertEqual(repositoryDetailsViewModelDelegateMock.didEndCounter, 1)
    }
}

// MARK: getRepositoryItem() -> Item? test
extension RepositoryDetailsViewModelTests {
    func testRepositoryDetailsViewModel_WhenGetRepositoryItemWasCalled_ShouldReturnRepositoryItemFromInit() {
        // Arrange (Given)
        
        // Act (When)
        let repositoryItem = sut.getRepositoryItem()
        
        // Assert (Then)
        XCTAssertEqual(self.searchRepositoriesResponseMock.getRepositoryItem(), repositoryItem)
    }
}
