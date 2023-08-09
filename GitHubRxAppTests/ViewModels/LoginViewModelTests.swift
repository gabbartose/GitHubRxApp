//
//  LoginViewModelTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

@testable import GitHubRxApp
import RxSwift
import RxTest
import XCTest

final class LoginViewModelTests: XCTestCase {
    
    private var loginViewModelDelegateMock: LoginViewModelDelegateMock!
    private var loginRepositoryMock: LoginRepositoryMock!
    private var sut: LoginViewModel!

    override func setUpWithError() throws {
        loginViewModelDelegateMock = LoginViewModelDelegateMock()
        loginRepositoryMock = LoginRepositoryMock()
        sut = LoginViewModel(loginRepository: loginRepositoryMock)
        sut.delegate = loginViewModelDelegateMock
    }

    override func tearDownWithError() throws {
        loginViewModelDelegateMock = nil
        loginRepositoryMock = nil
        sut = nil
    }
}

// MARK: showSearchRepositoriesScreen() test
extension LoginViewModelTests {
    func testLoginViewModel_WhenNavigateToSearchRepositoriesScreenWasCalled_ShouldCallShowSearchRepositoriesScreenOnDelegate() {
        // Arrange (Given)
        
        // Act (When)
        sut.navigateToSearchRepositoriesScreen()
        
        // Assert (Then)
        XCTAssertTrue(loginViewModelDelegateMock.showSearchRepositoriesScreenWasCalled)
        XCTAssertEqual(loginViewModelDelegateMock.showSearchRepositoriesScreenCounter, 1)
    }
}

// MARK: didEnd() test
extension LoginViewModelTests {
    func testLoginViewModel__WhenDidDissapearWasCalled_ShouldCallDidEndOnDelegate() {
        // Arrange (Given)
        
        // Act (When)
        sut.didDisappearViewController()
        
        // Assert (Then)
        XCTAssertTrue(loginViewModelDelegateMock.didEndWasCalled)
        XCTAssertEqual(loginViewModelDelegateMock.didEndCounter, 1)
    }
}
