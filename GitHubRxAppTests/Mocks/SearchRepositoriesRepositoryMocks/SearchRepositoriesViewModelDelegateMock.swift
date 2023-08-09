//
//  SearchRepositoriesViewModelDelegateMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class SearchRepositoriesViewModelDelegateMock: SearchRepositoriesViewModelDelegate {
    
    var didSelectRepositoryWasCalled = false
    var didSelectRepositoryCounter = 0
    
    var didSelectUserDetailsWasCalled = false
    var didSelectUserDetailsCounter = 0
    
    var didTapSignOutButtonWasCalled = false
    var didTapSignOutButtonCounter = 0
    
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
