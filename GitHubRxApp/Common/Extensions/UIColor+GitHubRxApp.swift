//
//  UIColor+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 17.07.2023..
//

import UIKit

extension UIColor {
    enum AssetsColor: String {
        case GBackgroundGray
        case GBlue
        case GBorderLightGray
        case GButtonBlue
        case GDarkGray
        case GLightGray
    }
    
    class var GBackgroundGray: UIColor { return from(.GBackgroundGray) }
    class var GBlue: UIColor { return from(.GBlue) }
    class var GBorderLightGray: UIColor { return from(.GBorderLightGray) }
    class var GButonBlue: UIColor { return from(.GButtonBlue) }
    class var GDarkGray: UIColor { return from(.GDarkGray) }
    class var GLightGray: UIColor { return from(.GLightGray) }
    
    private class func from(_ appColor: AssetsColor) -> UIColor {
        guard let color = UIColor(named: appColor.rawValue) else {
            fatalError("Trying to load undefined color: \(appColor)")
        }
        return color
    }
}

// We can set the color (AssetsColor) with the help of the function or with the help of class var
extension UIColor {
    static func setColor(_ name: AssetsColor) -> UIColor? {
        return UIColor(named: name.rawValue)
    }
}

// MARK: Hex colors
extension UIColor {
    static func from(hex: String?) -> UIColor? {
        guard let hex = hex else { return nil }
        var hexFormatted = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgb)
        
        if hexFormatted.count == 6 {
            return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                           green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                           blue: CGFloat(rgb & 0x0000FF) / 255.0,
                           alpha: 1)
        } else if hexFormatted.count == 8 {
            return UIColor(red: CGFloat((rgb & 0xFF000000) >> 24) / 255.0,
                           green: CGFloat((rgb & 0x00FF0000) >> 16) / 255.0,
                           blue: CGFloat((rgb & 0x0000FF00) >> 8) / 255.0,
                           alpha: CGFloat(rgb & 0x000000FF) / 255.0)
        } else {
            return nil
        }
    }
}
