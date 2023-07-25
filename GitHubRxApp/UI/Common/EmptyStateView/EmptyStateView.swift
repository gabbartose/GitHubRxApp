//
//  EmptyStateView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    
    struct Constants {
        static let gitHubSearchIcon = "GitHubSearchIcon"
        static let emptyStateLabelText = "There is currently no data. Search repositories with 3 or more characters."
        static let iconDistanceFromCenter = -UIScreen.main.bounds.height * 0.15
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.gitHubSearchIcon)
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: .ralewayBold, size: 14)
        label.textColor = .GDarkGray
        label.text = Constants.emptyStateLabelText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyStateView {
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(emptyStateLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(Constants.iconDistanceFromCenter)
            make.size.equalTo(170)
        }
        
        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
    }
}
