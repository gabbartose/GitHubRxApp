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
    func getUser()
    func navigateToSearchRepositoriesScreen()
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
        guard let signInURL =
                LoginManager.RequestType.signIn.networkRequest()?.url
        else {
            print("Could not create the sign in URL .")
            return
        }
        
        let callbackURLScheme = LoginManager.Constants.callbackURLScheme
        let authenticationSession = ASWebAuthenticationSession(
            url: signInURL,
            callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
                guard let self = self,
                      error == nil,
                      let callbackURL = callbackURL,
                      let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
                      let code = queryItems.first(where: { $0.name == "code" })?.value,
                      let networkRequest =
                        LoginManager.RequestType.codeExchange(code: code).networkRequest() else {
                    print("An error occurred when attempting to sign in.")
                    return
                }
                
                networkRequest.start(responseType: String.self) { result in
                    self.loadingInProgressSubject.onNext(false)
                    switch result {
                    case .success:
                        self.getUser()
                    case .failure(let error):
                        print("Failed to exchange access code for tokens: \(error)")
                    }
                }
            }
        
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        
        if !authenticationSession.start() {
            print("Failed to start ASWebAuthenticationSession")
        }
        loadingInProgressSubject.onNext(false)
    }
    
    func getUser() {
        loadingInProgressSubject.onNext(true)
        
        LoginManager
            .RequestType
            .getUser
            .networkRequest()?
            .start(responseType: User.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingInProgressSubject.onNext(false)
                    self.navigateToSearchRepositoriesScreen()
                case .failure(let error):
                    self.loadingInProgressSubject.onNext(false)
                    print("Failed to get user, or there is no valid/active session: \(error.localizedDescription)")
                }
            }
    }
    
    func didDisappearViewController() {
        delegate?.didEnd()
    }
    
    func navigateToSearchRepositoriesScreen() {
        delegate?.showSearchRepositoriesScreen()
    }
}

// MARK: Helper private methods
extension LoginViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window ?? ASPresentationAnchor()
    }
}
