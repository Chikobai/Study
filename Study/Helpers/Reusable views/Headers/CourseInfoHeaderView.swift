//
//  CourseInfoHeaderView.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoHeaderView: UIView {

    private lazy var videoPlaceholderImageView: UIImageView = UIImageView()
    private lazy var playButtonView: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoHeaderView")
    }
}

// MARK: - Builds

private extension CourseInfoHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        isHidden = true

        //video placeholder image view
        videoPlaceholderImageView.backgroundColor = AppColor.main.uiColor

        //play button view
        playButtonView.setImage(#imageLiteral(resourceName: "play-button (2) 6"), for: .normal)
        playButtonView.backgroundColor = .clear
        playButtonView.layer.cornerRadius = 18.0
        playButtonView.clipsToBounds = true
    }

    func buildLayouts() -> Void {

        addSubviews(with: [videoPlaceholderImageView, playButtonView])
        videoPlaceholderImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        playButtonView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(36.0)
        }
    }
}
