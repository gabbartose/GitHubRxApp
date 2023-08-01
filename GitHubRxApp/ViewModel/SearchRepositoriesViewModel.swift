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
    func showLoginScreen()
}

protocol SearchRepositoriesViewModelProtocol {
    var loadingInProgress: Observable<Bool> { get set }
    var onError: Observable<ErrorReport> { get set }
    var repositoryComponents: Observable<[Item]> { get set }
    var isFetchInProgress: Bool { get set }
    
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
    var isFetchInProgress = false
    
    private let searchRepositoriesRepository: SearchRepositoriesRepositoryProtocol
    private let loadingInProgressSubject = PublishSubject<Bool>()
    private let onErrorSubject = PublishSubject<ErrorReport>()
    private let repositoryComponentsSubject = PublishSubject<[Item]>()
    
    private var currentPage = 0
    private var numberOfItemsPerPage = 20
    private var repositoryItems: [Item] = []
    private var oldQueryString = ""
    private var oldSortOption = ""
    
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
            if oldQueryString != currentQueryString {
                setCurrentPageAndRepositoryItemsToDefault()
                oldQueryString = currentQueryString
            }

            if oldSortOption != sortOption {
                setCurrentPageAndRepositoryItemsToDefault()
                oldSortOption = sortOption
            }
            
            getRepositoryComponents(query: currentQueryString, sortOption: sortOption)
            return
        }
        
        repositoryComponentsSubject.onNext([])
    }
    
    func didSelectRepository(item: Item) {
        guard !EnvironmentProvider.shared.isTest() else { return }
        delegate?.didSelectRepository(item: item)
    }
    
    func didSelectUserImageView(userDetails: Owner) {
        guard EnvironmentProvider.shared.isProduction() else { return }
        delegate?.didSelectUserDetails(userDetails: userDetails)
    }
    
    func didTapSignOutButton() {
        LoginManager.signOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.delegate?.showLoginScreen()
        }
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
