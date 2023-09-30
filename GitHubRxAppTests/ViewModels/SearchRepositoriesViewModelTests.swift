//
//  SearchRepositoriesViewModelTests.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

@testable import GitHubRxApp
import RxSwift
import RxTest
import XCTest

final class SearchRepositoriesViewModelTests: XCTestCase {
    private var searchRepositoriesViewModelDelegateMock: SearchRepositoriesViewModelDelegateMock!
    private var searchRepositoriesResponseMock: SearchRepositoriesResponseMock!
    private var searchRepositoriesRepositoryMock: SearchRepositoriesRepositoryMock!
    private var sut: SearchRepositoriesViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        searchRepositoriesViewModelDelegateMock = SearchRepositoriesViewModelDelegateMock()
        searchRepositoriesRepositoryMock = SearchRepositoriesRepositoryMock()
        searchRepositoriesResponseMock = SearchRepositoriesResponseMock()
        sut = SearchRepositoriesViewModel(searchRepositoriesRepository: searchRepositoriesRepositoryMock)
        sut.delegate = searchRepositoriesViewModelDelegateMock
        scheduler = TestScheduler(initialClock: 0, resolution: 1)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        searchRepositoriesViewModelDelegateMock = nil
        searchRepositoriesRepositoryMock = nil
        searchRepositoriesResponseMock = nil
        sut = nil
        scheduler = nil
        disposeBag = nil
    }
}

// MARK: func didEnter(currentQueryString: String, sortOption: String) test
extension SearchRepositoriesViewModelTests {
    func testSearchRepositoriesViewModel_WhenDidEnterWasCalledWithLessThanThreeCharacters_ThenSearchRepositoriesItemsShouldBeEmpty() {
        // Arrange (Given)
        let queryString = "iO"

        // Act (When)
        scheduler.scheduleAt(10) { [weak self] in
            self?.sut.didEnter(currentQueryString: queryString)
        }

        let observer = scheduler.record(sut.repositoryComponents, disposeBag: disposeBag)
        scheduler.start()

        // Assert (Then)
        XCTAssertEqual(observer.events, [.next(10, [])])
        XCTAssertFalse(searchRepositoriesRepositoryMock.getRepositoriesWasCalled)
        XCTAssertEqual(searchRepositoriesRepositoryMock.getRepositoriesCounter, 0)
        XCTAssertNotEqual(searchRepositoriesRepositoryMock.query, queryString)
    }

    func testSearchRepositoriesViewModel_WhenDidEnterWasCalledWithMoreThanThreeCharacters_ShouldCallRepositoriesRepositoryGetRepositories() {
        // Arrange (Given)
        let queryString = "Android"

        // Act (When)
        sut.didEnter(currentQueryString: queryString)

        // Assert (Then)
        XCTAssertTrue(searchRepositoriesRepositoryMock.getRepositoriesWasCalled)
        XCTAssertEqual(searchRepositoriesRepositoryMock.getRepositoriesCounter, 1)
        XCTAssertEqual(searchRepositoriesRepositoryMock.query, queryString)
    }

    func testSearchRepositoriesViewModel_WhenDidEnterCalledWithMoreThanThreeCharacters_ShouldPostLoadingInProgressTrueThanFalse() {
        // Arrange (Given)
        let queryString = "Github"

        // Act (When)
        scheduler.scheduleAt(10) { [weak self] in
            self?.sut.didEnter(currentQueryString: queryString)
        }

        let observer = scheduler.record(sut.loadingInProgress, disposeBag: disposeBag)
        scheduler.start()

        // Assert (Then)
        XCTAssertEqual(observer.events, [.next(10, true), .next(10, false)])
    }

    func testSearchRepositoriesViewModel_WhenDidEnterCalledWithMoreThanThreeCharacters_ShouldPostRepositoryComponents() {
        // Arrange (Given)
        let queryString = "Python"

        // Act (When)
        scheduler.scheduleAt(10) {[weak self] in
            self?.sut.didEnter(currentQueryString: queryString)
        }

        let observer = scheduler.record(sut.repositoryComponents, disposeBag: disposeBag)
        scheduler.start()

        // Assert (Then)
        XCTAssertEqual(observer.events, [.next(10, searchRepositoriesRepositoryMock.searchRepositoriesRepositoryResponse.items)])
    }

    func testSearchRepositoriesViewModel_WhenDidEnterCalledWithMoreThanThreeCharacters_ShouldPostOnError() {
        // Arrange (Given)
        let queryString = "Backend"
        let errorReport = ErrorReport(cause: .invalidResponse, data: nil)
        searchRepositoriesRepositoryMock.errorReport = errorReport

        // Act (When)
        scheduler.scheduleAt(10) { [weak self] in
            self?.sut.didEnter(currentQueryString: queryString)
        }

        let observer = scheduler.record(sut.onError, disposeBag: disposeBag)
        scheduler.start()

        // Assert (Then)
        XCTAssertEqual(observer.events, [.next(10, errorReport)])
    }
}

// MARK: didSelectRepository(item: Item) test
extension SearchRepositoriesViewModelTests {
    func testSearchRepositoriesViewModel_WhenDidSelectRepositoryCalled_ShouldCallDidSelectRepositoryOnDelegate() {
        // Arrange (Given)

        // Act (When)
        sut.didSelectRepository(item: searchRepositoriesResponseMock.getRepositoryItem())

        // Assert (Then)
        XCTAssertTrue(searchRepositoriesViewModelDelegateMock.didSelectRepositoryWasCalled)
        XCTAssertEqual(searchRepositoriesViewModelDelegateMock.didSelectRepositoryCounter, 1)
    }
}

// MARK: didSelectUserDetails(userDetails: Owner) test
extension SearchRepositoriesViewModelTests {
    func testSearchRepositoriesViewModel_WhenDidSelectUserDetails_ShouldCallDidSelectUserImageViewOnDelegate() {
        // Arrange (Given)

        // Act (When)
        sut.didSelectUserImageView(userDetails: searchRepositoriesResponseMock.getOwnerItem())

        // Assert (Then)
        XCTAssertTrue(searchRepositoriesViewModelDelegateMock.didSelectUserDetailsWasCalled)
        XCTAssertEqual(searchRepositoriesViewModelDelegateMock.didSelectUserDetailsCounter, 1)
    }
}

// MARK: didTapSignOutButton test
extension SearchRepositoriesViewModelTests {
    func testSearchRepositoriesViewModel_WhenDidTapSignOutButton_ShouldCallDidTapSignOutButtonOnDelegate() {
        // Arrange (Given)

        // Act (When)
        sut.didTapSignOutButton()

        // Assert (Then)
        XCTAssertTrue(searchRepositoriesViewModelDelegateMock.didTapSignOutButtonWasCalled)
        XCTAssertEqual(searchRepositoriesViewModelDelegateMock.didTapSignOutButtonCounter, 1)
    }
}
