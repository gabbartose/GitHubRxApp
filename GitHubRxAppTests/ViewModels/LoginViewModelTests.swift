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
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        loginViewModelDelegateMock = LoginViewModelDelegateMock()
        loginRepositoryMock = LoginRepositoryMock()
        sut = LoginViewModel(loginRepository: loginRepositoryMock)
        sut.delegate = loginViewModelDelegateMock
        scheduler = TestScheduler(initialClock: 0, resolution: 1)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        loginViewModelDelegateMock = nil
        loginRepositoryMock = nil
        sut = nil
        scheduler = nil
        disposeBag = nil
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
    func testLoginViewModel_WhenDidDissapearWasCalled_ShouldCallDidEndOnDelegate() {
        // Arrange (Given)
        
        // Act (When)
        sut.didDisappearViewController()
        
        // Assert (Then)
        XCTAssertTrue(loginViewModelDelegateMock.didEndWasCalled)
        XCTAssertEqual(loginViewModelDelegateMock.didEndCounter, 1)
    }
}

// MARK: didSelectLoginButton() tests
extension LoginViewModelTests {
    func testLoginViewModel_WhenLoginButtonSelected_ShouldPostLoadingInProgressToTrue() {
        // Arrange (Given)
        
        // Act (When)
        scheduler.scheduleAt(10) { [weak self] in
            self?.sut.didSelectLoginButton()
        }
        
        let observer = scheduler.record(sut.loadingInProgress, disposeBag: disposeBag)
        scheduler.start()
        
        // Assert (Then)
        XCTAssertEqual(observer.events, [.next(10, true)])
    }
}
