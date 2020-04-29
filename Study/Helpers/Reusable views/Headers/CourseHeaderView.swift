//
//  CourseHeaderView.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseHeaderView: UIView {

    var toJoinCoursePressed: (()->())?

    private lazy var courseIconImageView: UIImageView = UIImageView()
    private lazy var courseNameLabelView: UILabel = UILabel()
    private lazy var communityView: CourseCommunityView = CourseCommunityView()
    private lazy var ratingView: CourseRatingView = CourseRatingView()
    private lazy var joinButtonView: LoadingButton = LoadingButton()

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

    func configure(with course: Course) -> Void {

        joinButtonView.setTitle(course.is_my_course ? AppTitle.CourseDetails.joinedCourse : AppTitle.CourseDetails.toJoinCourse, for: .normal)
        courseNameLabelView.text = course.name
        communityView.configure(with: course.user_counts, #imageLiteral(resourceName: "avatar 3"))
        ratingView.configure(with: course.rating ?? 5.0)

        if course.is_my_course == true {
            joinButtonView.backgroundColor = AppColor.main.uiColor.withAlphaComponent(0.5)
        }
    }

    func setIsSubscribedCourse(with value: Bool) -> Void {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.joinButtonView.setTitle(value ? AppTitle.CourseDetails.joinedCourse : AppTitle.CourseDetails.toJoinCourse, for: .normal)
            if value == true {
                self.joinButtonView.backgroundColor = AppColor.main.uiColor.withAlphaComponent(0.5)
            }
        }
    }

    func startLoading() -> Void {
        joinButtonView.startLoading()
    }

    func stopLoading() -> Void {
        joinButtonView.stopLoading()
    }
}

extension CourseHeaderView {

    @objc func joinCoursePressed() -> Void {
        
        toJoinCoursePressed?()
    }
}

// MARK: - Builds

private extension CourseHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superviews
        backgroundColor = .white

        //course icon image view
        courseIconImageView.image = #imageLiteral(resourceName: "Ellipse 18")
        courseIconImageView.layer.cornerRadius = 43.byWidth()
        courseIconImageView.clipsToBounds = true

        //course name label view
        courseNameLabelView.font = .systemFont(ofSize: 18.byWidth())
        courseNameLabelView.textColor = AppColor.black.uiColor

        //join button view
        joinButtonView.backgroundColor = AppColor.main.uiColor
        joinButtonView.setTitleColor(AppColor.white.uiColor, for: .normal)
        joinButtonView.contentHorizontalAlignment = .left
        joinButtonView.layer.cornerRadius = 21.byWidth()
        joinButtonView.titleEdgeInsets = .init(top: 0, left: 20.byWidth(), bottom: 0, right: 0)

    }

    func buildLayouts() -> Void {

        addSubviews(with: [courseIconImageView, courseNameLabelView, communityView, ratingView, joinButtonView])
        courseIconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(25.byWidth())
            make.width.height.equalTo(86.byWidth())
        }

        courseNameLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(courseIconImageView.snp.right).offset(20.byWidth())
            make.right.equalTo(-20.byWidth())
            make.top.equalTo(35.byWidth())
        }

        communityView.snp.makeConstraints { (make) in
            make.top.equalTo(courseNameLabelView.snp.bottom).offset(15.byWidth())
            make.left.equalTo(courseNameLabelView)
        }

        ratingView.snp.makeConstraints { (make) in
            make.centerY.equalTo(communityView)
            make.left.equalTo(communityView.snp.right).offset(20.byWidth())
        }

        joinButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(courseIconImageView.snp.bottom).offset(13.byWidth())
            make.right.bottom.equalTo(-8.byWidth())
            make.left.equalTo(8.byWidth())
        }
    }

    func buildTargets() -> Void {

        joinButtonView.addTarget(self, action: #selector(joinCoursePressed), for: .touchUpInside)
    }
}
