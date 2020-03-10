//
//  CourseCommunityView.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseCommunityView: UIView {

    private lazy var countLabelView: UILabel = UILabel()
    private lazy var iconView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseCommunityView")
    }

    func configure(with count: Int, _ icon: UIImage) {

        self.countLabelView.text = "\(count)"
        self.iconView.image = icon
    }
}

// MARK: Builds

private extension CourseCommunityView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //title label view
        countLabelView.font = .systemFont(ofSize: 12)
        countLabelView.textColor = AppColor.darkGray.uiColor

    }

    func buildLayouts() -> Void {

        addSubviews(with: [countLabelView, iconView])

        iconView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(13)
            make.height.equalTo(14)
            make.left.equalTo(5)
        }

        countLabelView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconView.snp.right).offset(5)
            make.right.equalTo(-5)
        }
    }
}
