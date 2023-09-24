//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import AuthenticationServices
import RxSwift

protocol LoginViewModelDelegate: AnyObject {
    func showSearchRepositoriesScreen()
    func didEnd()
}

protocol LoginViewModelProtocol {
    var loadingInProgress: Observable<Bool> { get set }
    var onError: Observable<ErrorReport> { get set }
    
    func didSelectLoginButton()
    func didDisappearViewController()
    func navigateToSearchRepositoriesScreen()
}

final class LoginViewModel: NSObject, LoginViewModelProtocol {
    var loadingInProgress: Observable<Bool>
    var onError: Observable<ErrorReport>
    
    weak var delegate: LoginViewModelDelegate?
    
    private let loginRepository: LoginRepositoryProtocol
    private let loadingInProgressSubject = PublishSubject<Bool>()
    private let onErrorSubject = PublishSubject<ErrorReport>()
    private var isLoginButtonDisabled = false
    
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
        guard let signInURL = loginRepository.createSignInURLWithClientId(),
              let callbackURLScheme = Bundle.main.object(forInfoDictionaryKey: "CallbackURLScheme") as? String
        else {
            print("Could not create the sign in URL.")
            return
        }
        
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
                guard let self = self,
                      error == nil,
                      let callbackURL = callbackURL,
                      let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                      let code = queryItems.first(where: { $0.name == "code" })?.value else {
                    print("An error occurred when attempting to sign in.")
                    self?.isLoginButtonDisabled = false
                    return
                }
                
                loginRepository.codeExchange(code: code) { [weak self] result in
                    guard let self = self else { return }
                    self.loadingInProgressSubject.onNext(false)
                    switch result {
                    case .success:
                        getUser()
                    case .failure(let errorReport):
                        self.onErrorSubject.onNext(errorReport)
                        print("Failed to exchange access code for tokens: \(errorReport), \(errorReport.cause)")
                        self.isLoginButtonDisabled = false
                    }
                }
            }
        
        guard !isLoginButtonDisabled else {
            loadingInProgressSubject.onNext(false)
            return
        }
        
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        
        if !authenticationSession.start() {
            print("Failed to start ASWebAuthenticationSession")
            isLoginButtonDisabled = false
        }
        
        loadingInProgressSubject.onNext(false)
        isLoginButtonDisabled = true
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
    
    func navigateToSearchRepositoriesScreen() {
        delegate?.showSearchRepositoriesScreen()
    }
    
    private func getUser() {
        loadingInProgressSubject.onNext(true)
        
        loginRepository.getUser { [weak self] result in
            guard let self = self else { return }
            self.loadingInProgressSubject.onNext(false)
            switch result {
            case .success:
                self.navigateToSearchRepositoriesScreen()
            case .failure(let errorReport):
                self.onErrorSubject.onNext(errorReport)
                print("Failed to get user, or there is no valid/active session: \(errorReport.localizedDescription), \(errorReport.cause)")
                isLoginButtonDisabled = false
            }
        }
    }
}

// MARK: Helper methods
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
