//
//  LoginViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit

class LoginViewController: UIViewController {
    
    private var loginView: LoginView {
        guard let view = self.view as? LoginView else { fatalError("There is no LoginView") }
        return view
    }
    
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = LoginView()
        setupLoginButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            viewModel.didDisappearViewController()
        }
    }
    
    deinit {
        print("deinit LoginViewController")
    }
}

extension LoginViewController {
    private func setupLoginButton() {
        loginView.onDidSelectLoginButton = viewModel.didSelectLoginButton
    }
}
