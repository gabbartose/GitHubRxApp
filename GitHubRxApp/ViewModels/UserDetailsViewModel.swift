//
//  UserDetailsViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import Foundation

protocol UserDetailsViewModelDelegate: AnyObject {
    func didTapAdditionalInfoInBrowser(htmlURL: String)
    func didEnd()
}

protocol UserDetailsViewModelProtocol {
    func getUserDetails() -> Owner
    func didTapAdditionalInfoInBrowser(htmlURL: String)
    func didDisappearViewController()
}

final class UserDetailsViewModel: UserDetailsViewModelProtocol {
    private let userDetails: Owner

    weak var delegate: UserDetailsViewModelDelegate?

    init(userDetails: Owner) {
        self.userDetails = userDetails
    }

    deinit {
        print("deinit UserDetailsViewModel")
    }
}

extension UserDetailsViewModel {
    func getUserDetails() -> Owner {
        return userDetails
    }

    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        delegate?.didTapAdditionalInfoInBrowser(htmlURL: htmlURL)
    }

    func didDisappearViewController() {
        delegate?.didEnd()
    }
}
