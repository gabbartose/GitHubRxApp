//
//  UserDetailsViewModelDelegateMock.swift
//  GitHubRxAppTests
//
//  Created by Gabrijel Bartosek on 09.08.2023..
//

import Foundation
@testable import GitHubRxApp

class UserDetailsViewModelDelegateMock: UserDetailsViewModelDelegate {
    var didTapAdditionalInfoInBrowserWasCalled = false
    var didTapAdditionalInfoInBrowserCounter = 0
    var htmlURL: String?

    var didEndWasCalled = false
    var didEndCounter = 0

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
