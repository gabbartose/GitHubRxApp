//
//  UserDetailsView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit
import SnapKit

class UserDetailsView: UIView, BasicViewMethodsProtocol {
    
    struct Constants {
        static let imageViewDimension = UIScreen.main.bounds.width / 1.5
    }
    
    enum UserDetailsStackViewLabels: String {
        
        case id = "ID:"
        case nodeId = "Node ID:"
        case loginName = "Login name:"
        case type = "Type:"
        case siteAdmin = "Site admin:"
    }
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    lazy var imageView = UIImageView()
    
    private lazy var mainVerticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [
            idLabel.stackView,
            nodeIdLabel.stackView,
            loginNameLabel.stackView,
            typeLabel.stackView,
            siteAdminLabel.stackView
        ])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        return verticalStackView
    }()
        
    lazy var idLabel = UIStackView.createHorizontalStackView(with: UserDetailsStackViewLabels.id.rawValue)
    lazy var nodeIdLabel = UIStackView.createHorizontalStackView(with: UserDetailsStackViewLabels.nodeId.rawValue)
    lazy var loginNameLabel = UIStackView.createHorizontalStackView(with: UserDetailsStackViewLabels.loginName.rawValue)
    lazy var typeLabel = UIStackView.createHorizontalStackView(with: UserDetailsStackViewLabels.type.rawValue)
    lazy var siteAdminLabel = UIStackView.createHorizontalStackView(with: UserDetailsStackViewLabels.siteAdmin.rawValue)
    
    lazy var userDetailsLabel = UILabel.setupLabel(with: "Open user details in external browser",
                                                   textColor: .gButonBlue,
                                                   isUserInteractionEnabled: true)
    
    init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        setupConstraints()
        setupHorizontalStackViewTitleLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserDetailsView {
    
    internal func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(imageView)
        contentView.addSubview(mainVerticalStackView)
        contentView.addSubview(userDetailsLabel)
    }
    
    internal func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constants.imageViewDimension)
        }
        
        mainVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        userDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(mainVerticalStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

// MARK: Helper methods
extension UserDetailsView {
    
    private func setupHorizontalStackViewTitleLabels() {
        idLabel.titleLabel.text = UserDetailsStackViewLabels.id.rawValue
        nodeIdLabel.titleLabel.text = UserDetailsStackViewLabels.nodeId.rawValue
        loginNameLabel.titleLabel.text = UserDetailsStackViewLabels.loginName.rawValue
        typeLabel.titleLabel.text = UserDetailsStackViewLabels.type.rawValue
        siteAdminLabel.titleLabel.text = UserDetailsStackViewLabels.siteAdmin.rawValue
    }
}
