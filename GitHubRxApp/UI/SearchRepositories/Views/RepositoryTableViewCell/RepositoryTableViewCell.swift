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
    
    enum RepositoryStackViewLabel: String {
        case watchersLabel = "Watchers"
        case forksLabel = "Forks"
        case issuesLabel = "Issues"
        case starsLabel = "Stars"
    }
    
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var numberOfWatchersLabel: UILabel!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var numberOfIssuesLabel: UILabel!
    @IBOutlet weak var numberOfStarsLabel: UILabel!
    @IBOutlet weak var updatedDateLabel: UILabel!
    
    lazy var watchersVerticalStackView = UIStackView.createVerticalStackView(with: RepositoryStackViewLabel.watchersLabel.rawValue)
    lazy var forksVerticalStackView = UIStackView.createVerticalStackView(with: RepositoryStackViewLabel.forksLabel.rawValue)
    lazy var issuesVerticalStackView = UIStackView.createVerticalStackView(with: RepositoryStackViewLabel.issuesLabel.rawValue)
    lazy var starsVerticalStackView = UIStackView.createVerticalStackView(with: RepositoryStackViewLabel.starsLabel.rawValue)
    
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
            numberOfWatchersLabel.text = "\(watchersCount)"
            numberOfForksLabel.text = "\(forksCount)"
            numberOfIssuesLabel.text = "\(issuesCount)"
            numberOfStarsLabel.text = "\(starsCount)"
            updatedDateLabel.text = "\(Date.convertDate(date: updatedDate))"
        }
        
        self.repositoryItem = item
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setRoundedCornerRadius()
        addGesture()
    }
}

// MARK: Helper methods
extension RepositoryTableViewCell {
    
    private func setRoundedCornerRadius() {
        authorImageView.setupImageViewProperties(with: authorImageView.bounds.size.width / 2.0)
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
