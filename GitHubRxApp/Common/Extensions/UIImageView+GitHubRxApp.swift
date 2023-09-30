//
//  UIImageView+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit

extension UIImageView {
    
    func setupCornerRadius(with cornerRadius: CGFloat) {
        contentMode = .scaleAspectFit
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
