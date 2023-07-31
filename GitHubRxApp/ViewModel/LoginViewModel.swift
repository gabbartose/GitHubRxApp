//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import AuthenticationServices
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

class LoginViewModel: NSObject, LoginViewModelProtocol {
    
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
        loadingInProgressSubject.onNext(true)
        let callbackURLScheme = NetworkManager.Constants.callbackURLScheme
        let signInURL = loginRepository.createSignInURLWithClientId()
        let authenticationSession = ASWebAuthenticationSession(url: signInURL,
                                                               callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
            guard let self = self else { return }
            // TODO: Further implementation
            //                guard error == nil,
            //                      let callbackURL = callbackURL else {
            //                    self.loadingInProgressSubject.onNext(false)
            //                }
            //                print("An error occurred when attempting to sign in.")
            //                return
        }
        
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        
        if !authenticationSession.start() {
            print("Failed to start ASWebAuthenticationSession")
        }
        self.loadingInProgressSubject.onNext(false)
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
}

// MARK: Helper private methods
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
