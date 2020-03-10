//
//  ReviewItem.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import Cosmos

class ReviewItem: UITableViewCell {

    private lazy var reviewerImageView: UIImageView = UIImageView()
    private lazy var reviewedTimeView: UILabel = UILabel()
    private lazy var reviewerNameView: UILabel = UILabel()
    private lazy var commentView: UILabel = UILabel()
    private lazy var ratingView: CosmosView = CosmosView()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: ReviewItem")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        ratingView.prepareForReuse()
    }

    func configure(with comment: String) -> Void {
        commentView.text = comment
    }
}

// MARK: - Builds

private extension ReviewItem {

    func build() -> Void {

        buildViews()
        buildLayout()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //reviewer image view
        reviewerImageView.layer.cornerRadius = 19.0
        reviewerImageView.image = #imageLiteral(resourceName: "8aa0748250185d0dba6c4ec4b217680e")
        reviewerImageView.contentMode = .scaleToFill
        reviewerImageView.clipsToBounds = true

        //reviewed time view
        reviewedTimeView.font = .systemFont(ofSize: 8.0)
        reviewedTimeView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        reviewedTimeView.text = "3 дня назад"

        //reviewer name view
        reviewerNameView.font = .systemFont(ofSize: 10.0)
        reviewerNameView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        reviewerNameView.text = "Aibow Shadibek"

        //comment view
        commentView.font = .systemFont(ofSize: 10.0)
        commentView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        commentView.numberOfLines = 0

        //rating view
        ratingView.settings.filledImage = #imageLiteral(resourceName: "star")
        ratingView.settings.updateOnTouch = false
        ratingView.settings.starSize = 12
        ratingView.rating = 4.5
    }

    func buildLayout() -> Void {

        addSubviews(with: [reviewerImageView, reviewedTimeView, reviewerNameView, commentView, ratingView])
        reviewerImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(38.0)
            make.top.left.equalTo(20.0)
        }

        reviewedTimeView.snp.makeConstraints { (make) in
            make.top.equalTo(reviewerImageView.snp.top).offset(5.0)
            make.left.equalTo(reviewerImageView.snp.right).offset(11.0)
        }

        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(18.0)
            make.right.equalTo(-28.0)
//            make.height.equalTo(30)
        }

        reviewerNameView.snp.makeConstraints { (make) in
            make.top.equalTo(reviewedTimeView.snp.bottom).offset(5.0)
            make.left.equalTo(reviewedTimeView)
        }

        commentView.snp.makeConstraints { (make) in
            make.top.equalTo(reviewerImageView.snp.bottom)
            make.left.equalTo(reviewerNameView)
            make.right.equalTo(-16.0)
            make.bottom.equalTo(-20.0)
        }
    }
}
