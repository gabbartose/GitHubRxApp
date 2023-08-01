//
//  UILabel+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 21.07.2023..
//

import UIKit

extension UILabel {
    
    static func setupLabel(with title: String? = "",
                           font: UIFont = .ralewayMedium(size: 14) ?? UIFont.systemFont(ofSize: 14),
                           textColor: UIColor,
                           textAlignment: NSTextAlignment = .left,
                           numberOfLines: Int = 0,
                           isUserInteractionEnabled: Bool = false) -> UILabel {
        let label = UILabel()
        label.font = font
        label.adjustsFontForContentSizeCategory = true
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = numberOfLines
        label.isUserInteractionEnabled = isUserInteractionEnabled
        label.text = title
        return label
    }
}
