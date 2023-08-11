//
//  UIFont+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

extension UIFont {
    
    enum FontName: String {
        case ralewayMedium = "Raleway-Medium"
        case ralewayMediumItalic = "Raleway-MediumItalic"
        case ralewayBold = "Raleway-Bold"
        case ralewayExtraBold = "Raleway-ExtraBold"
    }
    
    static let ralewayMedium = UIFont(name: .ralewayMedium, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
    static let ralewayMediumItalic = UIFont(name: .ralewayMediumItalic, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
    static let ralewayBold = UIFont(name: .ralewayBold, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
    static let ralewayExtraBold = UIFont(name: .ralewayExtraBold, size: 14.0) ?? UIFont.systemFont(ofSize: 14)
    
    convenience init?(name fontName: FontName, size fontSize: CGFloat) {
        self.init(name: fontName.rawValue, size: fontSize)
    }
    
    static func ralewayMedium(size: CGFloat) -> UIFont! {
        return UIFont(name: .ralewayMedium, size: size)
    }
    
    static func ralewayMediumItalic(size: CGFloat) -> UIFont! {
        return UIFont(name: .ralewayMediumItalic, size: size)
    }
    
    static func ralewayBold(size: CGFloat) -> UIFont! {
        return UIFont(name: .ralewayBold, size: size)
    }
    
    static func ralewayExtraBold(size: CGFloat) -> UIFont! {
        return UIFont(name: .ralewayExtraBold, size: size)
    }
}
