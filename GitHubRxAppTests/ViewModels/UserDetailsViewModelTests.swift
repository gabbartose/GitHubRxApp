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
