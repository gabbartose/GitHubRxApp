//
//  UserDetailsView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import SnapKit

final class UserDetailsView: UIView, BasicViewMethodsProtocol {
    
    struct Constants {
        static let authorImageSize = UIScreen.main.bounds.width / 1.6
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
    
    lazy var authorImageView = AuthorImageView(frame: CGRect(x: 0, y: 0, width: Constants.authorImageSize, height: Constants.authorImageSize))
    
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
        
        contentView.addSubview(authorImageView)
        contentView.addSubview(mainVerticalStackView)
        contentView.addSubview(userDetailsLabel)
    }
    
    internal func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(250)
        }
        
        authorImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(Constants.authorImageSize)
        }
        
        mainVerticalStackView.snp.makeConstraints {
            $0.top.equalTo(authorImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        userDetailsLabel.snp.makeConstraints {
            $0.top.equalTo(mainVerticalStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.bottom.lessThanOrEqualToSuperview().offset(-20)
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
