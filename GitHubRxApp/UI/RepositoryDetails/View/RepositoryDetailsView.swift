//
//  RepositoryDetailsView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 20.07.2023..
//

import UIKit
import SnapKit

class RepositoryDetailsView: UIView, BasicViewMethodsProtocol {
    
    enum RepositoryDetailsStackViewLabels: String {
        case programmingLanguage = "Programming language:"
        case dateOfCreation = "Date of creation:"
        case dateOfModification = "Date of modification:"
    }
    
    var bottomConstraint: Constraint?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    
    private lazy var mainVerticalStackView: UIStackView = {
        let verticalStackView = UIStackView(arrangedSubviews: [
            programmingLanguageLabel.stackView,
            dateOfCreationLabel.stackView,
            dateOfModificationLabel.stackView
        ])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 20
        return verticalStackView
    }()
    
    lazy var programmingLanguageLabel = UIStackView.createHorizontalStackView(with: RepositoryDetailsStackViewLabels.programmingLanguage.rawValue)
    lazy var dateOfCreationLabel = UIStackView.createHorizontalStackView(with: RepositoryDetailsStackViewLabels.dateOfCreation.rawValue)
    lazy var dateOfModificationLabel = UIStackView.createHorizontalStackView(with: RepositoryDetailsStackViewLabels.dateOfModification.rawValue)
    
    lazy var descriptionLabel = UILabel.setupLabel(textColor: .gDarkGray)
    
    lazy var repositoryDetailsExternalBrowserLabel = UILabel.setupLabel(with: "Open repository details in external browser",
                                                                        textColor: .gButonBlue,
                                                                        isUserInteractionEnabled: true)
    lazy var userDetailsLabel = UILabel.setupLabel(with: "Open user details screen",
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

extension RepositoryDetailsView {
    
    internal func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainVerticalStackView)
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(repositoryDetailsExternalBrowserLabel)
        contentView.addSubview(userDetailsLabel)
    }
    
    internal func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            bottomConstraint = make.bottom.equalToSuperview().constraint
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().priority(250)
        }
        
        mainVerticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainVerticalStackView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        repositoryDetailsExternalBrowserLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        
        userDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(repositoryDetailsExternalBrowserLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}

// MARK: Helper methods
extension RepositoryDetailsView {
    
    private func setupHorizontalStackViewTitleLabels() {
        programmingLanguageLabel.titleLabel.text = RepositoryDetailsStackViewLabels.programmingLanguage.rawValue
        dateOfCreationLabel.titleLabel.text = RepositoryDetailsStackViewLabels.dateOfCreation.rawValue
        dateOfModificationLabel.titleLabel.text = RepositoryDetailsStackViewLabels.dateOfModification.rawValue
    }
    
}
