//
//  LoginViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    struct Constants {
        static let activityIndicatorYOffset = -UIScreen.main.bounds.height * 0.05
    }
    
    private var loginView: LoginView {
        guard let view = self.view as? LoginView else { fatalError("There is no LoginView") }
        return view
    }
    
    private var viewModel: LoginViewModelProtocol
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        if isMovingFromParent {
            viewModel.didDisappearViewController()
        }
    }
    
    override func loadView() {
        self.view = LoginView()
        subscribeToViewModel()
        setupLoginButton()
    }
    
    deinit {
        print("deinit LoginViewController")
    }
}

extension LoginViewController {
    private func subscribeToViewModel() {
        viewModel
            .loadingInProgress
            .bind { [weak self] isInProgress in
                self?.activityIndicatorView(startAnimating: isInProgress, offsetFromYAxis: Constants.activityIndicatorYOffset)
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

extension LoginViewController {
    private func setupLoginButton() {
        loginView.onDidSelectLoginButton = viewModel.didSelectLoginButton
    }
}
