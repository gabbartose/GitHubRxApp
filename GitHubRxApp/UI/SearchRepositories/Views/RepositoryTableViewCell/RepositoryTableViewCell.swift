//
//  RepositoryTableViewCell.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 18.07.2023..
//

import Kingfisher
import SnapKit

final class RepositoryTableViewCell: UITableViewCell {
    
    struct Constants {
        static let avatarPlaceholder = "AvatarPlaceholder"
        static let updated = "Updated:"
    }
    
    enum RepositoryVerticalStackViewLabel: String {
        case watchersLabel = "Watchers"
        case forksLabel = "Forks"
        case issuesLabel = "Issues"
        case starsLabel = "Stars"
    }
    
    //    @IBOutlet weak var horizontalStackView: UIStackView!
    //    @IBOutlet weak var authorImageView: UIImageView!
    //    @IBOutlet weak var repositoryNameLabel: UILabel!
    //    @IBOutlet weak var authorNameLabel: UILabel!
    //    @IBOutlet weak var updatedDateLabel: UILabel!
    
    var onDidSelectAuthorImageView: ((Owner) -> ())?


    private lazy var authorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var mainVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayMedium, size: 18)
        label.textColor = .gDarkGray
        label.numberOfLines = 1
        return label
    }()

    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayMedium, size: 15)
        label.textColor = .gDarkGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var dateHorizondalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var updatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayMedium, size: 12)
        label.textColor = .gDarkGray
        label.numberOfLines = 1
        label.text = Constants.updated
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()

    private lazy var updatedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayMedium, size: 12)
        label.textColor = .gDarkGray
        label.numberOfLines = 1
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    private lazy var watchersVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.watchersLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    private lazy var forksVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.forksLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    private lazy var issuesVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.issuesLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    private lazy var starsVerticalStackView = UIStackView.createStackView(
        with: RepositoryVerticalStackViewLabel.starsLabel.rawValue,
        orientation: .vertical,
        spacing: 0)
    
    
    private lazy var watchersLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.watchersLabel.rawValue,
                                                        font: .ralewayMedium(size: 12),
                                                        textColor: .gDarkGray)
    
    private lazy var forksLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.forksLabel.rawValue,
                                                     font: .ralewayMedium(size: 12),
                                                     textColor: .gDarkGray)
    
    private lazy var issuesLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.issuesLabel.rawValue,
                                                      font: .ralewayMedium(size: 12),
                                                      textColor: .gDarkGray)
    
    private lazy var starsLabel = UILabel.setupLabel(with: RepositoryVerticalStackViewLabel.starsLabel.rawValue,
                                                     font: .ralewayMedium(size: 12),
                                                     textColor: .gDarkGray)
    
    private var repositoryItem: Item?
    
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
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        addVerticalStackViewInHorizontal()
    //        setRoundedCornerRadius()
    //        addGesture()
    //    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .gBackgroundMain

        addSubviews()
        setupConstraints()

        addVerticalStackViewInHorizontal()
        setRoundedCornerRadius()
        addGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Helper methods
private extension RepositoryTableViewCell {
    func setRoundedCornerRadius() {
        authorImageView.setupCornerRadius(with: 30)
    }
    
    func setupVerticalStackViewTitleLabels() {
        watchersVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.watchersLabel.rawValue
        forksVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.forksLabel.rawValue
        issuesVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.issuesLabel.rawValue
        starsVerticalStackView.titleLabel.text = RepositoryVerticalStackViewLabel.starsLabel.rawValue
    }
    
    func addVerticalStackViewInHorizontal() {
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

extension RepositoryTableViewCell: BasicViewMethodsProtocol {
    func addSubviews() {
        contentView.addSubview(authorImageView)
        contentView.addSubview(mainVerticalStackView)

        mainVerticalStackView.addArrangedSubview(repositoryNameLabel)
        mainVerticalStackView.addArrangedSubview(authorNameLabel)
        mainVerticalStackView.addArrangedSubview(horizontalStackView)
        mainVerticalStackView.addArrangedSubview(dateHorizondalStackView)

        dateHorizondalStackView.addArrangedSubview(updatedLabel)
        dateHorizondalStackView.addArrangedSubview(updatedDateLabel)
    }

    func setupConstraints() {
        authorImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(60)
        }

        mainVerticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.lessThanOrEqualToSuperview().offset(-10)
            $0.leading.equalTo(authorImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

// MARK: Gestures
private extension RepositoryTableViewCell {
    func addGesture() {
        let authorImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAuthorImageView))
        authorImageView.addGestureRecognizer(authorImageViewTapGesture)
    }
    
    @objc
    func didTapAuthorImageView() {
        guard let ownerItem = repositoryItem?.owner else { return }
        onDidSelectAuthorImageView?(ownerItem)
    }
}
