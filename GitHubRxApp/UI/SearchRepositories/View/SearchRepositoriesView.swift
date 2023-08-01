//
//  SearchRepositoriesView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 18.07.2023..
//

import UIKit
import SnapKit

class SearchRepositoriesView: UIView, BasicViewMethodsProtocol {
    
    struct Constants {
        static let searchGithubRepositoriesPlaceholder = "Search Github Repositories"
        static let filterIcon = "FilterIcon"
        static let currentlyLoggedInUser = "Currently logged in: "
    }
    
    var loggedInUserValue: String = ""
    
    private lazy var searchComponentsView = UIView()
    
    lazy var repositorySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .GBorderLightGray
        searchBar.layer.cornerRadius = 30
        searchBar.clearBackgroundColor()
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.font = UIFont(name: .ralewayMedium, size: 14)
        searchBar.searchTextField.attributedPlaceholder =
        NSAttributedString(string: Constants.searchGithubRepositoriesPlaceholder,
                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.GDarkGray])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchBar.searchTextField.leftView = paddingView
        searchBar.searchTextField.leftViewMode = .always
        searchBar.searchTextField.autocorrectionType = .no
        return searchBar
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.filterIcon), for: .normal)
        button.tintColor = .GBlue
        return button
    }()
    
    private lazy var grayBottomLineViewUnderSearch = GrayBottomLineView()
    
    private lazy var loggedInUserView = UIView()
    
    lazy var loggedInUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: .ralewayBold, size: 14)
        label.textColor = .GDarkGray
        label.text = Constants.currentlyLoggedInUser + loggedInUserValue
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        tableView.alwaysBounceVertical = false
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .GLightGray
        view.alpha = 0.95
        view.isHidden = true
        return view
    }()
    
    lazy var sortPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = .GBackgroundGray
        pickerView.layer.cornerRadius = 30
        return pickerView
    }()
    
    lazy var emptyStateView = EmptyStateView()
    
    init() {
        super.init(frame: CGRect.zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchRepositoriesView {
    
    internal func addSubviews() {
        addSubview(searchComponentsView)
        searchComponentsView.addSubview(repositorySearchBar)
        searchComponentsView.addSubview(filterButton)
        addSubview(grayBottomLineViewUnderSearch)
        
        addSubview(loggedInUserView)
        loggedInUserView.addSubview(loggedInUserLabel)
        
        addSubview(tableView)
        addSubview(emptyStateView)
        
        addSubview(backgroundView)
        backgroundView.addSubview(sortPickerView)
    }
    
    internal func setupConstraints() {
        searchComponentsView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        repositorySearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(filterButton.snp.leading).offset(-10)
            make.height.equalTo(55)
        }
        
        filterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.size.equalTo(35)
        }
        
        grayBottomLineViewUnderSearch.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchComponentsView.snp.bottom)
            make.height.equalTo(1)
        }
        
        loggedInUserView.snp.makeConstraints { make in
            make.top.equalTo(grayBottomLineViewUnderSearch.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        
        loggedInUserLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(loggedInUserView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(grayBottomLineViewUnderSearch.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        sortPickerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(200)
        }
    }
}
