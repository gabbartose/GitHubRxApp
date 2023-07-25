//
//  BaseViewController.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    struct Constants {
        static let activityIndicatorDistanceFromCenter = -UIScreen.main.bounds.height * 0.11
    }
    
    private var activityIndicatorView: UIActivityIndicatorView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: Activity Indicator View
extension BaseViewController {
    
    func activityIndicatorView(startAnimating: Bool) {
        switch startAnimating {
        case true:
            startActivityIndicatorView()
        case false:
            stopActivityIndicatorView()
        }
    }
    
    private func startActivityIndicatorView() {
        setUserInteraction(isEnabled: false)
        if activityIndicatorView == nil {
            addActivityIndicatorView()
        }
        
        activityIndicatorView?.startAnimating()
    }
    
    private func stopActivityIndicatorView() {
        activityIndicatorView?.stopAnimating()
        setUserInteraction(isEnabled: true)
    }
    
    private func setUserInteraction(isEnabled: Bool) {
        view.isUserInteractionEnabled = isEnabled
        navigationController?.view.isUserInteractionEnabled = isEnabled
    }
    
    private func addActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.color = .GBlue
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(Constants.activityIndicatorDistanceFromCenter)
        }
        
        self.activityIndicatorView = activityIndicatorView
    }
}
