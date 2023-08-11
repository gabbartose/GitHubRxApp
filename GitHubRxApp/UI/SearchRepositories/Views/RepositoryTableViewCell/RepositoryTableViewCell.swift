//
//  RepositoryTableViewCell.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 18.07.2023..
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    
    struct Constants {
        static let avatarPlaceholder = "AvatarPlaceholder"
    }
    
    enum RepositoryVerticalStackViewLabel: String {
        case watchersLabel = "Watchers"
        case forksLabel = "Forks"
        case issuesLabel = "Issues"
        case starsLabel = "Stars"
    }
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    lazy var watchersVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.watchersLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    lazy var forksVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.forksLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    lazy var issuesVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.issuesLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    lazy var starsVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.starsLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    
    lazy var watchersLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.watchersLabel.rawValue,
                                                font: .ralewayMedium(size: 12),
                                                textColor: .gDarkGray)
    
    lazy var forksLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.forksLabel.rawValue,
                                             font: .ralewayMedium(size: 12),
                                             textColor: .gDarkGray)
    
    lazy var issuesLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.issuesLabel.rawValue,
                                              font: .ralewayMedium(size: 12),
                                              textColor: .gDarkGray)
    
    lazy var starsLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.starsLabel.rawValue,
                                             font: .ralewayMedium(size: 12),
                                             textColor: .gDarkGray)
    
    private var repositoryItem: Item?
    var onDidSelectAuthorImageView: ((Owner) -> ())?
    
    func setupWith(item: Item, attributedString: NSMutableAttributedString) {
        authorImageView.kf.setImage(with: URL(string: item.owner?.avatarUrl ?? ""), placeholder: UIImage(named: Constants.avatarPlaceholder))
        repositoryNameLabel.attributedText = attributedString
        authorNameLabel.text = item.owner?.login
        
        if let watchersCount = item.watchersCount,
           let forksCount = item.forksCount,
           let issuesCount = item.openIssues,
           let starsCount = item.stargazersCount,
           let updatedDate = item.updatedAt {
            watchersVerticalStackView.descriptionLabel?.text = "\(watchersCount)"
            forksVerticalStackView.descriptionLabel?.text = "\(forksCount)"
            issuesVerticalStackView.descriptionLabel?.text = "\(issuesCount)"
            starsVerticalStackView.descriptionLabel?.text = "\(starsCount)"
            
            updatedDateLabel.text = "\(Date.convertDate(date: updatedDate))"
        }
        
        self.repositoryItem = item
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addVerticalStackViewInHorizontal()
        setRoundedCornerRadius()
        addGesture()
    }
}

// MARK: Helper methods
extension RepositoryTableViewCell {
    
    private func setRoundedCornerRadius() {
        authorImageView.setupImageViewProperties(with: authorImageView.bounds.size.width / 2.0)
    }
    
    private func setupVerticalStackViewTitleLabels() {
        watchersVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.watchersLabel.rawValue
        forksVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.forksLabel.rawValue
        issuesVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.issuesLabel.rawValue
        starsVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.starsLabel.rawValue
    }
    
    private func addVerticalStackViewInHorizontal() {
        let verticalStackView = UIStackView(arrangedSubviews: [
            watchersVerticalStackView.stackView,
            forksVerticalStackView.stackView,
            issuesVerticalStackView.stackView,
            starsVerticalStackView.stackView
        ])
        
        horizontalStackView.addArrangedSubview(verticalStackView)
        setupVerticalStackViewTitleLabels()
    }
}

// MARK: Gestures
extension RepositoryTableViewCell {
    
    private func addGesture() {
        let authorImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorImageView))
        authorImageView.addGestureRecognizer(authorImageViewTapGesture)
    }
    
    @objc
    private func didTapAuthorImageView() {
        guard let ownerItem = repositoryItem?.owner else { return }
        onDidSelectAuthorImageView?(ownerItem)
    }
}
