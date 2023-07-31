//
//  LoginViewModel.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import RxSwift
import AuthenticationServices

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
        print("Login button pressed!")
        // guard let url = getAuthPageURL() else { return }
        // TODO: Navigation to the SearchRepository Screen
        
        loadingInProgressSubject.onNext(true)
        loginRepository.signInUser { [weak self] result in
            guard let self = self else { return }
            self.loadingInProgressSubject.onNext(false)
//            switch result {
//            case .success(let userResponse):
//                print("User response: \(userResponse)")
//            case .failure(let errorReport):
//                print("Error: \(errorReport.localizedDescription)")
//                self.onErrorSubject.onNext(errorReport)
//            }
            
            let callbackURLScheme = NetworkManager.Constants.callbackURLScheme
            
//            guard let signInURL = URL(string: "https://github.com/login/oauth/authorize?client_id=Iv1.03eda0e0b6c3100b") else {
//                print("Could not create the sign in URL .")
//                return
//            }
            
            let signInURL = loginRepository.signInPathWithClientId()
            print(signInURL)
            
            let authenticationSession = ASWebAuthenticationSession(url: signInURL,
                                                                   callbackURLScheme: callbackURLScheme) { [weak self] callbackURL, error in
                
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
            
        }
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
