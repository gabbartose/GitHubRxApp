//
//  UserDetailsViewModelTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

@testable import GitHubRxApp
import XCTest

final class UserDetailsViewModelTests: XCTestCase {
    private var userDetailsViewModelDelegateMock: UserDetailsViewModelDelegateMock!
    private var searchRepositoriesResponseMock: SearchRepositoriesResponseMock!
    private var sut: UserDetailsViewModel!

    override func setUpWithError() throws {
        userDetailsViewModelDelegateMock = UserDetailsViewModelDelegateMock()
        searchRepositoriesResponseMock = SearchRepositoriesResponseMock()
        sut = UserDetailsViewModel(userDetails: searchRepositoriesResponseMock.getOwnerItem())
        sut.delegate = userDetailsViewModelDelegateMock
    }

    override func tearDownWithError() throws {
        userDetailsViewModelDelegateMock = nil
        searchRepositoriesResponseMock = nil
        sut = nil
    }
}

// MARK: didTapAdditionalInfoInBrowser(htmlURL: String) test
extension UserDetailsViewModelTests {
    func testUserDetailsViewModel_WhenDidTapAdditionalInfoInBrowserWasCalled_ShouldCallDidTapAdditionalInfoInBrowserOnDelegate() {
        // Arrange (Given)
        let htmlURLString = "https://github.com/owncloud"

        // Act (When)
        sut.didTapAdditionalInfoInBrowser(htmlURL: htmlURLString)

        // Assert (Then)
        XCTAssertTrue(userDetailsViewModelDelegateMock.didTapAdditionalInfoInBrowserWasCalled)
        XCTAssertEqual(userDetailsViewModelDelegateMock.didTapAdditionalInfoInBrowserCounter, 1)
        XCTAssertEqual(userDetailsViewModelDelegateMock.htmlURL, htmlURLString)
    }
}

// MARK: didEnd() test
extension UserDetailsViewModelTests {
    func testUserDetailsViewModel_WhenDidDissapearWasCalled_ShouldCallDidEndOnDelegate() {
        // Arrange (Given)

        // Act (When)
        sut.didDisappearViewController()

        // Assert (Then)
        XCTAssertTrue(userDetailsViewModelDelegateMock.didEndWasCalled)
        XCTAssertEqual(userDetailsViewModelDelegateMock.didEndCounter, 1)
    }
}

// MARK: getUserDetails() -> Owner test
extension UserDetailsViewModelTests {
    func testUserDetailsViewModel_WhenGetRepositoryItemWasCalled_ShouldReturnUserDetailsFromInit() {
        // Arrange (Given)

        // Act (When)
        let ownerItem = sut.getUserDetails()

        // Assert (Then)
        XCTAssertEqual(searchRepositoriesResponseMock.getOwnerItem(), ownerItem)
    }
}
