//
//  CourseDetailsViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit


class CourseDetailsViewController: UIViewController {

    private lazy var headerView: CourseHeaderView = CourseHeaderView()
    private lazy var coverViewOfPagerView: UIView = UIView()
    private lazy var pagerViewController: CourseDetailsPagerViewController = CourseDetailsPagerViewController()

    private var courseObject: Course?

    init(with course: Course) {
        self.courseObject = course
        super.init(nibName: nil, bundle: nil)
        headerView.configure(with: course)
        pagerViewController.configure(with: course.id)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseDetailsViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.isTranslucent = false
//    }
}

private extension CourseDetailsViewController {

    func toJoinCourse() -> Void {

        if let course_id = courseObject?.id {
            headerView.startLoading()
            Request.shared.join(with: course_id, complitionHandler: { (message) in
                self.headerView.stopLoading()
                self.headerView.setIsSubscribedCourse(with: true)
                self.courseObject?.is_my_course = true
                self.display(with: message)
            }) { (message) in
                self.headerView.stopLoading()
                self.display(with: message)
            }
        }
    }
}

// MARK: - Builds

private extension CourseDetailsViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor
    }

    func buildLayouts() -> Void {

        self.add(pagerViewController, onView: coverViewOfPagerView)
        view.addSubviews(with: [headerView, coverViewOfPagerView])

        let pagerControlHeight: CGFloat = 20.0
        let headerViewHeight: CGFloat = 175.0
        let navigationBarHeight = self.navigationController?.navigationBar.frame.maxY ?? 0

        headerView.snp.makeConstraints { (make) in
            make.centerX.top.width.equalToSuperview()
            make.height.equalTo(175)
        }

        coverViewOfPagerView.snp.makeConstraints { (make) in
            make.centerX.width.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.height - (navigationBarHeight + headerViewHeight - pagerControlHeight))
        }

    }

    func buildServices() -> Void {

        headerView.toJoinCoursePressed = { [weak self] in
            if self?.courseObject?.is_my_course == false {
                self?.toJoinCourse()
            }
        }
    }
}
