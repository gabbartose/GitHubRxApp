//
//  EmptyStateView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 19.07.2023..
//

import SnapKit

final class EmptyStateView: UIView {
    
    struct Constants {
        static let gitHubSearchIcon = "GitHubSearchIcon"
        static let emptyStateLabelText = "There is currently no data. Search repositories with 3 or more characters."
        static let iconDistanceFromCenter = -UIScreen.main.bounds.height * 0.15
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.gitHubSearchIcon)
        imageView.addShadow()
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayBold, size: 14)
        label.textColor = .gDarkGray
        label.text = Constants.emptyStateLabelText
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .gBackgroundMain
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyStateView: BasicViewMethodsProtocol {
    private func setupView() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(imageView)
        addSubview(emptyStateLabel)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(Constants.iconDistanceFromCenter)
            $0.size.equalTo(170)
        }
        
        emptyStateLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(25)
            $0.trailing.equalToSuperview().offset(-25)
        }
    }
}
