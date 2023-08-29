//
//  SearchRepositoriesViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import RxSwift

protocol SearchRepositoriesViewModelDelegate: AnyObject {
    func didSelectRepository(item: Item)
    func didSelectUserDetails(userDetails: Owner)
    func didTapSignOutButton()
}

protocol SearchRepositoriesViewModelProtocol {
    var loadingInProgress: Observable<Bool> { get set }
    var onError: Observable<ErrorReport> { get set }
    var repositoryComponents: Observable<[Item]> { get set }
    var pickerSortDataArray: Observable<[String]> { get set }
    var oldQueryString: String { get set }
    var oldSortOption: String { get set }
    var isFetchInProgress: Bool { get set }
    var isReachedEndOfList: Bool { get set }
    var selectedPickerChoice: String { get set }
    var username: String { get }
    
    func didEnter(currentQueryString: String, sortOption: String)
    func didSelectRepository(item: Item)
    func didSelectUserImageView(userDetails: Owner)
    func didTapSignOutButton()
}

class SearchRepositoriesViewModel: SearchRepositoriesViewModelProtocol {
    
    weak var delegate: SearchRepositoriesViewModelDelegate?
    
    var loadingInProgress: Observable<Bool>
    var onError: Observable<ErrorReport>
    var repositoryComponents: Observable<[Item]>
    var pickerSortDataArray: Observable<[String]> = Observable.of(["Best match", "Stars", "Forks", "Updated"])
    var oldQueryString = ""
    var selectedPickerChoice = ""
    var oldSortOption = ""
    var isFetchInProgress = false
    var isReachedEndOfList = false
    var username: String {
        if let data = KeychainHelper.standard.read(service: KeychainHelper.Constants.usernameKey,
                                                   account: KeychainHelper.Constants.githubString) {
            return String(data: data, encoding: .utf8) ?? ""
        } else {
            return ""
        }
    }
    
    private let searchRepositoriesRepository: SearchRepositoriesRepositoryProtocol
    private let loadingInProgressSubject = PublishSubject<Bool>()
    private let onErrorSubject = PublishSubject<ErrorReport>()
    private let repositoryComponentsSubject = PublishSubject<[Item]>()
    private var currentPage = 0
    private var numberOfItemsPerPage = 20
    private var repositoryItems: [Item] = []
    
    init(searchRepositoriesRepository: SearchRepositoriesRepositoryProtocol) {
        self.searchRepositoriesRepository = searchRepositoriesRepository
        loadingInProgress = loadingInProgressSubject.asObservable().distinctUntilChanged()
        onError = onErrorSubject.asObservable()
        repositoryComponents = repositoryComponentsSubject.asObservable()
    }
    
    deinit {
        print("deinit SearchRepositoriesViewModel")
    }
}

extension SearchRepositoriesViewModel {
    
    func didEnter(currentQueryString: String, sortOption: String = "") {
        guard currentQueryString.count < 3 else {
            
            if oldQueryString != currentQueryString || oldSortOption != sortOption {
                setCurrentPageAndRepositoryItemsToDefault()
            }

            getRepositoryComponents(query: currentQueryString, sortOption: sortOption)
            oldQueryString = currentQueryString
            oldSortOption = sortOption
            return
        }
        
        oldQueryString = currentQueryString
        repositoryComponentsSubject.onNext([])
    }
    
    func didTapSignOutButton() {
        KeychainHelper.standard.delete(service: KeychainHelper.Constants.accessToken, account: KeychainHelper.Constants.githubString)
        KeychainHelper.standard.delete(service: KeychainHelper.Constants.usernameKey, account: KeychainHelper.Constants.githubString)
        
        delegate?.didTapSignOutButton()
    }
    
    func didSelectRepository(item: Item) {
        // According to the task description on Readme.md, this function is only allowed if we are in a production nad staging app environments and not in a test environment
        guard !EnvironmentProvider.shared.isTest() else { return }
        delegate?.didSelectRepository(item: item)
    }
    
    func didSelectUserImageView(userDetails: Owner) {
        // According to the task description on Readme.md, this function is only allowed if we are in a production app environment
        guard EnvironmentProvider.shared.isProduction() else { return }
        delegate?.didSelectUserDetails(userDetails: userDetails)
    }
    
    private func getRepositoryComponents(query: String = "", sortOption: String = "") {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        loadingInProgressSubject.onNext(true)
        searchRepositoriesRepository.getRepositories(query: query,
                                               page: currentPage + 1,
                                               perPage: numberOfItemsPerPage,
                                               sort: sortOption) { [weak self] result in
            guard let self = self else { return }
            loadingInProgressSubject.onNext(false)
            isFetchInProgress = false
            switch result {
            case .success(let temporaryRepositoriesPerPage):
                guard !(temporaryRepositoriesPerPage.items.isEmpty) else {
                    repositoryComponentsSubject.onNext([])
                    return
                }
                currentPage += 1
                repositoryItems.append(contentsOf: temporaryRepositoriesPerPage.items)
                repositoryComponentsSubject.onNext(self.repositoryItems)
                print("Repository items count: \(self.repositoryItems.count)")
                
                guard numberOfItemsPerPage > temporaryRepositoriesPerPage.items.count else {
                    isReachedEndOfList = false
                    return
                }
                isReachedEndOfList = true
                
            case .failure(let errorReport):
                onErrorSubject.onNext(errorReport)
            }
        }
    }
    
    private func setCurrentPageAndRepositoryItemsToDefault() {
        currentPage = 0
        repositoryItems = []
    }
}
