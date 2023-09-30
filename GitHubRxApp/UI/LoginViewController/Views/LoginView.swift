//
//  LoginView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import SnapKit

final class LoginView: UIView, BasicViewMethodsProtocol {
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
        button.setTitleColor(UIColor.gButonLight, for: .normal)
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        button.addTarget(self, action: #selector(heldDown), for: .touchDown)
        button.addTarget(self, action: #selector(heldAndReleased), for: .touchDragExit)
        return button
    }()

    var onDidSelectLoginButton: (() -> Void)?

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
        centerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-40)
            $0.centerY.equalToSuperview()
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.size.equalTo(170)
            $0.centerX.equalToSuperview()
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

extension LoginView {
    @objc
    func loginButtonAction() {
        loginButton.backgroundColor = .gBlue
        onDidSelectLoginButton?()
    }

    @objc
    func heldDown() {
        loginButton.backgroundColor = .gSearchBarBackground
    }

    @objc
    func heldAndReleased() {
        loginButton.backgroundColor = .gBlue
    }
}
