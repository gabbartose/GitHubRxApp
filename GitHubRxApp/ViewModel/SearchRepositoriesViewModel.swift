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
}

protocol SearchRepositoriesViewModelProtocol {
    var loadingInProgress: Observable<Bool> { get set }
    var onError: Observable<ErrorReport> { get set }
    var repositoryComponents: Observable<[Item]> { get set }
    var isFetchInProgress: Bool { get set }
    
    func didEnter(currentQueryString: String, sortOption: String)
    func didSelectRepository(item: Item)
    func didSelectUserImageView(userDetails: Owner)
}

class SearchRepositoriesViewModel: SearchRepositoriesViewModelProtocol {
    
    weak var delegate: SearchRepositoriesViewModelDelegate?
    
    internal var loadingInProgress: Observable<Bool>
    internal var onError: Observable<ErrorReport>
    internal var repositoryComponents: Observable<[Item]>
    internal var isFetchInProgress = false
    
    private let repositoriesRepository: RepositoriesRepositoryProtocol
    private let loadingInProgressSubject = PublishSubject<Bool>()
    private let onErrorSubject = PublishSubject<ErrorReport>()
    private let repositoryComponentsSubject = PublishSubject<[Item]>()
    
    private var currentPage = 0
    private var numberOfItemsPerPage = 20
    private var repositoryItems: [Item] = []
    private var oldQueryString = ""
    private var oldSortOption = ""
    
    init(repositoriesRepository: RepositoriesRepositoryProtocol) {
        self.repositoriesRepository = repositoriesRepository
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
        delegate?.didSelectRepository(item: item)
    }
    
    func didSelectUserImageView(userDetails: Owner) {
        delegate?.didSelectUserDetails(userDetails: userDetails)
    }
    
    private func getRepositoryComponents(query: String = "", sortOption: String = "") {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        loadingInProgressSubject.onNext(true)
        repositoriesRepository.getRepositories(query: query,
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
