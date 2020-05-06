//
//  CourseRatingView.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import Cosmos

class CourseRatingView: UIView {

    private lazy var ratingLabelView: UILabel = UILabel()
    private lazy var ratingView: CosmosView = CosmosView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseRatingView")
    }

    func configure(with rating: Double) {

        self.ratingLabelView.text = "\(rating)"
        self.ratingView.rating = rating
    }
}

// MARK: Builds

private extension CourseRatingView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //rating label view
        ratingLabelView.font = .systemFont(ofSize: 9.byWidth())
        ratingLabelView.textColor = AppColor.darkGray.uiColor
        ratingLabelView.backgroundColor = AppColor.yellow.uiColor
        ratingLabelView.clipsToBounds = true
        ratingLabelView.textAlignment = .center
        ratingLabelView.layer.cornerRadius = 10.byWidth()

        //rating view
        ratingView.settings.filledImage = #imageLiteral(resourceName: "star")
        ratingView.settings.emptyImage = #imageLiteral(resourceName: "unstart")
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = Double(12.byWidth())
    }

    func buildLayouts() -> Void {

        addSubviews(with: [ratingLabelView, ratingView])

        ratingLabelView.snp.makeConstraints { (make) in
            make.left.bottom.top.equalToSuperview()
            make.height.width.equalTo(20.byWidth())
        }

        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(ratingLabelView.snp.right).offset(10.byWidth())
            make.right.equalToSuperview()
        }
    }
}
