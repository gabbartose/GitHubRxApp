//
//  RepositoryDetailsViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 20.07.2023..
//

import SnapKit

final class RepositoryDetailsViewController: BaseViewController {
    
    struct Constants {
        static let noDataLabel = "There is currently no data for this record."
    }
    
    private var repositoryDetailsView: RepositoryDetailsView {
        guard let view = self.view as? RepositoryDetailsView else { fatalError("There is no RepositoryDetailsView") }
        return view
    }
    
    private let viewModel: RepositoryDetailsViewModelProtocol
    private var repositoryItem: Item?
    private var bottomConstraint: Constraint?
    
    init(viewModel: RepositoryDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = RepositoryDetailsView()
        bottomConstraint = repositoryDetailsView.bottomConstraint
        getRepositoryItem()
        setupNavigationItemTitle()
        setupLabels()
        setupGestures()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            viewModel.didDisappearViewController()
        }
    }
    
    deinit {
        print("deinit RepositoryDetailsViewController")
    }
}

// MARK: Helper methods
extension RepositoryDetailsViewController {
    
    private func getRepositoryItem() {
        repositoryItem = viewModel.getRepositoryItem()
    }
    
    private func setupNavigationItemTitle() {
        navigationItem.title = repositoryItem?.name
    }
    
    private func setupLabels() {
        repositoryDetailsView.programmingLanguageHorizontalStackView.descriptionLabel?.text = repositoryItem?.language ?? Constants.noDataLabel
        repositoryDetailsView.dateOfCreationHorizontalStackView.descriptionLabel?.text = Date.convertDate(date: repositoryItem?.createdAt ?? Constants.noDataLabel)
        repositoryDetailsView.dateOfModificationHorizontalStackView.descriptionLabel?.text = Date.convertDate(date: repositoryItem?.updatedAt ?? Constants.noDataLabel)
        repositoryDetailsView.descriptionLabel.text = repositoryItem?.description ?? Constants.noDataLabel
    }
}

// MARK: Gestures
extension RepositoryDetailsViewController {
    private func setupGestures() {
        let repositoryExternalBrowserTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDetailsInformationInExternalBrowser))
        repositoryDetailsView.repositoryDetailsExternalBrowserLabel.addGestureRecognizer(repositoryExternalBrowserTapGesture)

        let informationAboutOwnerTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapInformationAboutOwner))
        repositoryDetailsView.userDetailsLabel.addGestureRecognizer(informationAboutOwnerTapGesture)
    }
    
    @objc
    private func didTapDetailsInformationInExternalBrowser() {
        guard let htmlURLString = repositoryItem?.htmlUrl else { return }
        viewModel.didTapAdditionalInfoInBrowser(htmlURL: htmlURLString)
    }
    
    @objc
    private func didTapInformationAboutOwner() {
        guard let userDetails = repositoryItem?.owner else { return }
        viewModel.didSelectUserDetails(userDetails: userDetails)
    }
    
}
