//
//  RepositoryDetailsViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 20.07.2023..
//

import Foundation

protocol RepositoryDetailsViewModelDelegate: AnyObject {
    func didSelectUserDetails(userDetails: Owner)
    func didTapAdditionalInfoInBrowser(htmlURL: String)
    func didEnd()
}

protocol RepositoryDetailsViewModelProtocol {
    func didSelectUserDetails(userDetails: Owner)
    func didTapAdditionalInfoInBrowser(htmlURL: String)
    func getRepositoryItem() -> Item?
    func didDisappearViewController()
}

class RepositoryDetailsViewModel: RepositoryDetailsViewModelProtocol {

    private let repositoryItem: Item
    
    weak var delegate: RepositoryDetailsViewModelDelegate?
    
    init(repositoryItem: Item) {
        self.repositoryItem = repositoryItem
    }
    
    deinit {
        print("deinit RepositoryDetailsViewModel")
    }
}

extension RepositoryDetailsViewModel {
    
    func getRepositoryItem() -> Item? {
        return repositoryItem
    }
    
    func didTapAdditionalInfoInBrowser(htmlURL: String) {
        delegate?.didTapAdditionalInfoInBrowser(htmlURL: htmlURL)
    }
    
    func didSelectUserDetails(userDetails: Owner) {
        guard EnvironmentProvider.shared.isProduction() else { return }
        delegate?.didSelectUserDetails(userDetails: userDetails)
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
}
