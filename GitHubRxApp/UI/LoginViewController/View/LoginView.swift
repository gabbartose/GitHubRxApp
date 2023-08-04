//
//  LoginView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit
import SnapKit

class LoginView: UIView, BasicViewMethodsProtocol {
    
    struct Constants {
        static let gitHubSearchIcon = "GitHubSearchIcon"
        static let buttonText = "Login"
        static let centerViewHeight = UIScreen.main.bounds.height * 0.50
    }
    
    private lazy var centerView = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.gitHubSearchIcon)
        imageView.addShadow()
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonText, for: .normal)
        button.titleLabel?.font = .ralewayExtraBold(size: 20)
        button.backgroundColor = .gBlue
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addShadow()
        button.setTitleColor(UIColor.gButonBlue, for: .normal)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    var onDidSelectLoginButton: (() -> ())?
    
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView {
    
    internal func addSubviews() {
        addSubview(centerView)
        centerView.addSubview(imageView)
        centerView.addSubview(loginButton)
    }
    
    internal func setupConstraints() {
        centerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.size.equalTo(170)
            make.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}

extension LoginView {
    @objc
    func loginButtonAction() {
        onDidSelectLoginButton?()
    }
}
