//
//  UserDetailsViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit
import Kingfisher

class UserDetailsViewController: BaseViewController {
    
    struct Constants {
        static let avatarPlaceholder = "AvatarPlaceholder"
        static let imageViewDimension = UIScreen.main.bounds.width / 1.5
    }
    
    private var userDetailsView: UserDetailsView {
        guard let view = self.view as? UserDetailsView else { fatalError("Ther is no UserDetailsView") }
        return view
    }
    
    private var viewModel: UserDetailsViewModelProtocol
    private var userDetails: Owner?
    
    init(viewModel: UserDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = UserDetailsView()
        getUserDetails()
        setupNavigationItemTitle()
        setupElements()
        setupGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            viewModel.didDisappearViewController()
        }
    }
    
    deinit {
        print("deinit UserDetailsViewController")
    }
}

// MARK: Helper methods
extension UserDetailsViewController {
    
    private func getUserDetails() {
        userDetails = viewModel.getUserDetails()
    }
    
    private func setupElements() {
        userDetailsView.imageView.kf.setImage(with: URL(string: userDetails?.avatarUrl ?? ""), placeholder: UIImage(named: Constants.avatarPlaceholder))
        userDetailsView.imageView.setupImageViewProperties(with: Constants.imageViewDimension / 2)
        
        if let id = userDetails?.id,
           let nodeId = userDetails?.nodeId,
           let loginName = userDetails?.login,
           let type = userDetails?.type,
           let siteAdmin = userDetails?.siteAdmin {
            userDetailsView.idLabel.descriptionLabel.text = "\(id)"
            userDetailsView.nodeIdLabel.descriptionLabel.text = "\(nodeId)"
            userDetailsView.loginNameLabel.descriptionLabel.text = loginName
            userDetailsView.typeLabel.descriptionLabel.text = type
            userDetailsView.siteAdminLabel.descriptionLabel.text = "\(siteAdmin)"
        }
    }
    
    private func setupNavigationItemTitle() {
        navigationItem.title = userDetails?.login
    }
}

// MARK: Gestures
extension UserDetailsViewController {
    
    private func setupGesture() {
        let userDetailsExternalBrowserLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDetailsInformationsInExternalBrowser))
        userDetailsView.userDetailsLabel.addGestureRecognizer(userDetailsExternalBrowserLabelTapGesture)
    }
    
    @objc
    private func didTapDetailsInformationsInExternalBrowser() {
        guard let htmlURL = userDetails?.htmlUrl else { return }
        viewModel.didTapAdditionalInfoInBrowser(htmlURL: htmlURL)
    }
}
