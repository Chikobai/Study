//
//  CourseHeaderView.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseHeaderView: UIView {

    private lazy var courseIconImageView: UIImageView = UIImageView()
    private lazy var courseNameLabelView: UILabel = UILabel()
    private lazy var communityView: CourseCommunityView = CourseCommunityView()
    private lazy var ratingView: CourseRatingView = CourseRatingView()
    private lazy var joinButtonView: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseHeaderView")
    }

}

// MARK: - Builds

private extension CourseHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superviews
        backgroundColor = .white

        //course icon image view
        courseIconImageView.image = #imageLiteral(resourceName: "Ellipse 18")
        courseIconImageView.layer.cornerRadius = 43.0
        courseIconImageView.clipsToBounds = true

        //course name label view
        courseNameLabelView.font = .systemFont(ofSize: 18)
        courseNameLabelView.textColor = AppColor.black.uiColor
        courseNameLabelView.text = "Discrete mathematics"

        //community view
        communityView.configure(with: 342, #imageLiteral(resourceName: "avatar 3"))

        //course rating view
        ratingView.configure(with: 3.5)

        //join button view
        joinButtonView.backgroundColor = AppColor.main.uiColor
        joinButtonView.setTitle("Join course", for: .normal)
        joinButtonView.setTitleColor(AppColor.white.uiColor, for: .normal)
        joinButtonView.contentHorizontalAlignment = .left
        joinButtonView.layer.cornerRadius = 21
        joinButtonView.titleEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)

    }

    func buildLayouts() -> Void {

        addSubviews(with: [courseIconImageView, courseNameLabelView, communityView, ratingView, joinButtonView])
        courseIconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(25.0)
            make.width.height.equalTo(86.0)
        }

        courseNameLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(courseIconImageView.snp.right).offset(20.0)
            make.right.equalTo(-20.0)
            make.top.equalTo(35.0)
        }

        communityView.snp.makeConstraints { (make) in
            make.top.equalTo(courseNameLabelView.snp.bottom).offset(15.0)
            make.left.equalTo(courseNameLabelView)
        }

        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(communityView)
            make.left.equalTo(communityView.snp.right).offset(20.0)
        }

        joinButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(courseIconImageView.snp.bottom).offset(13.0)
            make.right.bottom.equalTo(-8.0)
            make.left.equalTo(8.0)
        }

    }
}
