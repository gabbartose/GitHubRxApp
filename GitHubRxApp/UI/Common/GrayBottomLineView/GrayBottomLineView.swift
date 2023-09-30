//
//  GrayBottomLineView.swift
//  GitHubRxApp
//
//  Created by Gabrijel Bartosek on 18.07.2023..
//

import SnapKit

final class GrayBottomLineView: UIView {
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .gBorderLightGray
        setupConstraints()
    }

    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
}
