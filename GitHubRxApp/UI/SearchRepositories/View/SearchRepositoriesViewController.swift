//
//  SearchRepositoriesViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import RxSwift
import RxCocoa

class SearchRepositoriesViewController: BaseViewController {
    
    struct Constants {
        static var repositoryTableViewCell = "RepositoryTableViewCell"
    }
    
    private var searchRepositoriesView: SearchRepositoriesView {
        guard let view = self.view as? SearchRepositoriesView else { fatalError("There is no SearchRepositoriesView.") }
        return view
    }
    
    private var viewModel: SearchRepositoriesViewModelProtocol
    private var queryString = ""
    private let disposeBag = DisposeBag()
    
    private var repositoryComponents = [Item]() {
        didSet {
            guard !repositoryComponents.isEmpty else {
                searchRepositoriesView.emptyStateView.isHidden = false
                searchRepositoriesView.tableView.isHidden = true
                searchRepositoriesView.tableView.reloadData()
                return
            }
            searchRepositoriesView.emptyStateView.isHidden = true
            searchRepositoriesView.tableView.isHidden = false
            searchRepositoriesView.tableView.reloadData()
        }
    }
    
    init(viewModel: SearchRepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = SearchRepositoriesView()
        setupNavigationBarElements()
        setupUIDelegates()
        setupSearchBar()
        setupTableView()
        setupGestures()
        subscribeToViewModel()
        NetworkManager.printTokens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit SearchRepositoriesViewController")
    }
}

// MARK: Subscribe to SearchRepositoriesViewModel
extension SearchRepositoriesViewController {
    
    private func subscribeToViewModel() {
        viewModel
            .repositoryComponents
            .bind { [weak self] repositoryComponents in
                self?.repositoryComponents = repositoryComponents
            }
            .disposed(by: disposeBag)
        
        viewModel
            .repositoryComponents.bind(to: searchRepositoriesView.tableView.rx.items(cellIdentifier: Constants.repositoryTableViewCell,
                                                                                     cellType: RepositoryTableViewCell.self)) { [weak self] row, repositoryComponent, cell in
                guard let self = self else { return }
                let attributedString = self.getAttributedString(query: repositoryComponent.name ?? "")
                cell.onDidSelectAuthorImageView = self.viewModel.didSelectUserImageView(userDetails:)
                cell.setupWith(item: repositoryComponent, attributedString: attributedString)
            }.disposed(by: disposeBag)
        
        viewModel
            .loadingInProgress
            .bind { [weak self] isInProgress in
                self?.activityIndicatorView(startAnimating: isInProgress)
            }
            .disposed(by: disposeBag)
        
        viewModel
            .onError
            .bind { [weak self] errorReport in
                ErrorHandler(rootViewController: self).handle(errorReport)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: Setup UI delegates and elements
extension SearchRepositoriesViewController {
    private func setupUIDelegates() {
        searchRepositoriesView.sortPickerView.delegate = self
        searchRepositoriesView.sortPickerView.dataSource = self
    }
}

// MARK: Setup UINavigationBar elements
extension SearchRepositoriesViewController {
    private func setupNavigationBarElements() {
        navigationItem.title = "Repository search"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(didTapSignOutButton))
    }
}

// MARK: UIPickerView methods
extension SearchRepositoriesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PickerValues.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = viewModel.pickerSortDataArray[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 1:
            viewModel.selectedPickerChoice = PickerValues.stars.rawValue
        case 2:
            viewModel.selectedPickerChoice = PickerValues.forks.rawValue
        case 3:
            viewModel.selectedPickerChoice = PickerValues.updated.rawValue
        default:
            viewModel.selectedPickerChoice = PickerValues.bestMatch.rawValue
        }
        
        guard viewModel.oldSortOption != viewModel.selectedPickerChoice else {
            searchRepositoriesView.backgroundView.isHidden = true
            return
        }
        viewModel.didEnter(currentQueryString: queryString, sortOption: viewModel.selectedPickerChoice)
        print("CurrentQueryString: \(queryString), SortOption: \(viewModel.selectedPickerChoice)")
        
        searchRepositoriesView.backgroundView.isHidden = true
        guard !repositoryComponents.isEmpty else { return }
        scrollToTop()
    }
}

// MARK: Setup UISearchBar elements
extension SearchRepositoriesViewController {
    private func setupSearchBar() {
        searchRepositoriesView.repositorySearchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(700), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { [unowned self] _ in return self.searchRepositoriesView.repositorySearchBar.text ?? "" }
            .subscribe(onNext: { [weak self] searchedText in
                guard let self = self else { return }
                guard viewModel.oldQueryString != searchedText else {
                    return
                }
                viewModel.didEnter(currentQueryString: searchedText, sortOption: self.viewModel.selectedPickerChoice)
                self.queryString = searchedText
            })
            .disposed(by: disposeBag)
        
        searchRepositoriesView.repositorySearchBar.rx
            .cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.searchRepositoriesView.repositorySearchBar.resignFirstResponder()
                self?.searchRepositoriesView.repositorySearchBar.showsCancelButton = false
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Setup UITableView elements
extension SearchRepositoriesViewController {
    private func setupTableView() {
        searchRepositoriesView.tableView.registerUINib(ofType: RepositoryTableViewCell.self)
        
        searchRepositoriesView.tableView.rx.modelSelected(Item.self).subscribe(onNext: { item in
            self.viewModel.didSelectRepository(item: item)
        }).disposed(by: disposeBag)
        
        searchRepositoriesView.tableView.rx.willDisplayCell
            .subscribe(onNext: ({ [weak self] cell, indexPath in
                guard let self = self,
                      indexPath.section == searchRepositoriesView.tableView.numberOfSections - 1,
                      indexPath.row == searchRepositoriesView.tableView.numberOfRows(inSection: indexPath.section) - 1,
                      !viewModel.isFetchInProgress,
                      !viewModel.isReachedEndOfList else {
                    return
                }
                viewModel.didEnter(currentQueryString: queryString, sortOption: viewModel.selectedPickerChoice)
            })).disposed(by: disposeBag)
    }
}

// MARK: Helper methods
// TODO: Consider to move those functions to the SearchRepositoriesViewModel
extension SearchRepositoriesViewController {
    private func getAttributedString(query: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: query)
        let range = (query as NSString).range(of: queryString, options: .caseInsensitive)
        guard let boldFont = UIFont(name: .ralewayExtraBold, size: 18) else { fatalError("Font doesn't exist") }
        attributedString.addAttribute(NSAttributedString.Key.font, value: boldFont, range: range)
        return attributedString
    }
    
    private func setPickerOnDefaultValue() {
        viewModel.selectedPickerChoice = PickerValues.bestMatch.rawValue
        searchRepositoriesView.sortPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        searchRepositoriesView.tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
}

// MARK: Gestures
extension SearchRepositoriesViewController {
    private func setupGestures() {
        let filterButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFilterButton))
        searchRepositoriesView.filterButton.addGestureRecognizer(filterButtonTapGesture)
        
        let backgroundViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapBackgroundView))
        searchRepositoriesView.backgroundView.addGestureRecognizer(backgroundViewTapGesture)
    }
    
    @objc
    private func didTapSignOutButton() {
        viewModel.didTapSignOutButton()
    }
    
    @objc
    private func didTapFilterButton() {
        searchRepositoriesView.backgroundView.isHidden = false
    }
    
    @objc
    private func didTapBackgroundView() {
        searchRepositoriesView.backgroundView.isHidden = true
    }
}
