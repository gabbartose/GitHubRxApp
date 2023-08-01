//
//  UIStackView+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit

extension UIStackView {
    
    static func createHorizontalStackView(with title: String) -> (stackView: UIStackView, titleLabel: UILabel, descriptionLabel: UILabel) {
        let titleLabel = UILabel.setupLabel(font: .ralewayExtraBold, textColor: .GDarkGray)
        let descriptionLabel = UILabel.setupLabel(font: .ralewayBold, textColor: .GDarkGray)
        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .leading
        horizontalStackView.spacing = 10
        
        return (horizontalStackView, titleLabel, descriptionLabel)
    }
}
