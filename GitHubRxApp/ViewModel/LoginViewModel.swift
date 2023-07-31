//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import RxSwift

protocol LoginViewModelDelegate: AnyObject {
    func didEnd()
}

protocol LoginViewModelProtocol {
    var loadingInProgress: Observable<Bool> { get set }
    var onError: Observable<ErrorReport> { get set }
    
    func didSelectLoginButton()
    func didDisappearViewController()
}

class LoginViewModel: LoginViewModelProtocol {
    
    var loadingInProgress: Observable<Bool>
    var onError: Observable<ErrorReport>
    
    
    weak var delegate: LoginViewModelDelegate?
    
    private let loginRepository: LoginRepositoryProtocol
    private let loadingInProgressSubject = PublishSubject<Bool>()
    private let onErrorSubject = PublishSubject<ErrorReport>()
    
    init(loginRepository: LoginRepositoryProtocol) {
        self.loginRepository = loginRepository
        loadingInProgress = loadingInProgressSubject.asObservable().distinctUntilChanged()
        onError = onErrorSubject.asObservable()
    }
    
    deinit {
        print("deinit LoginViewModel")
    }
}

// MARK: LoginViewModelDelegate necessary methods
extension LoginViewModel {
    func didSelectLoginButton() {
        print("Login button pressed!")
        // guard let url = getAuthPageURL() else { return }
        // TODO: Navigation to the SearchRepository Screen
        
        loadingInProgressSubject.onNext(true)
        
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
}

// MARK: Helper private methods
extension LoginViewModel {
    
}
