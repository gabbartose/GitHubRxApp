//
//  UserDetailsView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import SnapKit

final class UserDetailsView: UIView, BasicViewMethodsProtocol {
    
    struct Constants {
        static let imageViewDimension = UIScreen.main.bounds.width / 1.6
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
            idHorizontalStackView.stackView,
            nodeIdHorizontalStackView.stackView,
            loginNameHorizontalStackView.stackView,
            typeHorizontalStackView.stackView,
            siteAdminHorizontalStackView.stackView
        ])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        return verticalStackView
    }()
        
    lazy var idHorizontalStackView = UIStackView.createStackView(with: UserDetailsStackViewLabels.id.rawValue)
    lazy var nodeIdHorizontalStackView = UIStackView.createStackView(with: UserDetailsStackViewLabels.nodeId.rawValue)
    lazy var loginNameHorizontalStackView = UIStackView.createStackView(with: UserDetailsStackViewLabels.loginName.rawValue)
    lazy var typeHorizontalStackView = UIStackView.createStackView(with: UserDetailsStackViewLabels.type.rawValue)
    lazy var siteAdminHorizontalStackView = UIStackView.createStackView(with: UserDetailsStackViewLabels.siteAdmin.rawValue)
    
    lazy var userDetailsLabel = UILabel.setupLabel(with: "Open user details in external browser",
                                                   textColor: .gBlue,
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
            make.top.equalToSuperview().offset(30)
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
private extension UserDetailsView {
    func setupHorizontalStackViewTitleLabels() {
        idHorizontalStackView.titleLabel.text = UserDetailsStackViewLabels.id.rawValue
        nodeIdHorizontalStackView.titleLabel.text = UserDetailsStackViewLabels.nodeId.rawValue
        loginNameHorizontalStackView.titleLabel.text = UserDetailsStackViewLabels.loginName.rawValue
        typeHorizontalStackView.titleLabel.text = UserDetailsStackViewLabels.type.rawValue
        siteAdminHorizontalStackView.titleLabel.text = UserDetailsStackViewLabels.siteAdmin.rawValue
    }
}
