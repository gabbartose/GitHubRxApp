//
//  RepositoryDetailsViewModelDelegateMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class RepositoryDetailsViewModelDelegateMock: RepositoryDetailsViewModelDelegate {
    var didSelectUserDetailsWasCalled = false
    var didSelectUserDetailsWasCounter = 0
    var ownerItem: Owner?

    var didTapAdditionalInfoInBrowserWasCalled = false
    var didTapAdditionalInfoInBrowserCounter = 0
    var htmlURL: String?

    var didEndWasCalled = false
    var didEndCounter = 0

    func didSelectUserDetails(userDetails: Owner) {
        didSelectUserDetailsWasCalled = true
        didSelectUserDetailsWasCounter += 1
        self.ownerItem = userDetails
    }

    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        didTapAdditionalInfoInBrowserWasCalled = true
        didTapAdditionalInfoInBrowserCounter += 1
        self.htmlURL = htmlURL
    }

    func didEnd() {
        didEndWasCalled = true
        didEndCounter += 1
    }
}
