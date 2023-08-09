//
//  SearchRepositoriesViewModelDelegateMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesViewModelDelegateMock: SearchRepositoriesViewModelDelegate {
    
    private var didSelectRepositoryWasCalled = false
    private var didSelectRepositoryCounter = 0
    
    private var didSelectUserDetailsWasCalled = false
    private var didSelectUserDetailsCounter = 0
    
    private var didTapSignOutButtonWasCalled = false
    private var didTapSignOutButtonCounter = 0
    
    func didSelectRepository(item: Item) {
        didSelectRepositoryWasCalled = true
        didSelectRepositoryCounter += 1
    }
    
    func didSelectUserDetails(userDetails: Owner) {
        didSelectUserDetailsWasCalled = true
        didSelectUserDetailsCounter += 1
    }
    
    func didTapSignOutButton() {
        didTapSignOutButtonWasCalled = true
        didTapSignOutButtonCounter += 1
    }
}
