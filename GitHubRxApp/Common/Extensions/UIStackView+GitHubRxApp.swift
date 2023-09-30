//
//  UIStackView+GitHubRxApp.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 24.07.2023..
//

import UIKit

extension UIStackView {
    static func createStackView(with title: String,
                                orientation: NSLayoutConstraint.Axis = .horizontal,
                                spacing: CGFloat = 10) -> (stackView: UIStackView, titleLabel: UILabel, descriptionLabel: UILabel?) {
        let titleLabel: UILabel
        let descriptionLabel: UILabel

        if orientation == .horizontal {
            titleLabel = UILabel.setupLabel(font: .ralewayExtraBold(size: 14), textColor: .gDarkGray)
            descriptionLabel = UILabel.setupLabel(font: .ralewayExtraBold(size: 14), textColor: .gDarkGray)
        } else {
            titleLabel = UILabel.setupLabel(font: .ralewayMedium(size: 12), textColor: .gDarkGray)
            descriptionLabel = UILabel.setupLabel(font: .ralewayMedium(size: 12), textColor: .gDarkGray)
        }

        let horizontalStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])

        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        horizontalStackView.axis = orientation
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.alignment = .leading
        horizontalStackView.spacing = spacing

        return (horizontalStackView, titleLabel, descriptionLabel)
    }
}
