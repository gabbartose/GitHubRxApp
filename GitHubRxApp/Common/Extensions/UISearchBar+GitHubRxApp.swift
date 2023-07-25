//
//  UISearchBar+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 18.07.2023..
//

import UIKit

extension UISearchBar {
    func clearBackgroundColor() {
        guard let UISearchBarBackground: AnyClass = NSClassFromString("UISearchBarBackground") else { return }
        
        for view in subviews {
            for subview in view.subviews where subview.isKind(of: UISearchBarBackground) {
                subview.alpha = 0
            }
        }
    }
}
