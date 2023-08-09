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
    
    private var sut: SearchRepositoriesViewModel!
    private var searchRepositoriesRepositoryMock: SearchRepositoriesRepositoryMock!
    private var searchRepositoriesViewModelDelegateMock: SearchRepositoriesViewModelDelegateMock!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        searchRepositoriesViewModelDelegateMock = SearchRepositoriesViewModelDelegateMock()
        searchRepositoriesRepositoryMock = SearchRepositoriesRepositoryMock()
        sut = SearchRepositoriesViewModel(searchRepositoriesRepository: searchRepositoriesRepositoryMock)
        sut.delegate = searchRepositoriesViewModelDelegateMock
        scheduler = TestScheduler(initialClock: 0, resolution: 1)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        searchRepositoriesViewModelDelegateMock = nil
        searchRepositoriesRepositoryMock = nil
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
}
