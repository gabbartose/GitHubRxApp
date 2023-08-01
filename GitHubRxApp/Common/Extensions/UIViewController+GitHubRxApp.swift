//
//  UIViewController+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 01.08.2023..
//

import UIKit

extension UIViewController {
    func hideNavigationBar(animated: Bool){
        // Hide the navigation bar on the this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool) {
        // Show the navigation bar on other view controllers
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
