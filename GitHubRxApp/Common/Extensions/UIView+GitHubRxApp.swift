//
//  UIView+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 27.07.2023..
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowColor = UIColor.gDarkGray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 5
        layer.masksToBounds = false
    }
}
