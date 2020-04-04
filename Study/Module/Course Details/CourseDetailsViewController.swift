//
//  CourseDetailsViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit


class CourseDetailsViewController: ScrollViewController {

    private lazy var headerView: CourseHeaderView = CourseHeaderView()
    private lazy var coverViewOfPagerView: UIView = UIView()
    private lazy var pagerViewController: CourseDetailsPagerViewController = CourseDetailsPagerViewController()

    private var courseIdentifier: Int?

    init(with course: Course) {
        super.init(nibName: nil, bundle: nil)
        self.courseIdentifier = course.id
        self.pagerViewController.configure(with: course.id)
        headerView.configure(with: course)
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
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        super.viewWillAppear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        super.viewDidDisappear(animated)
    }
}

private extension CourseDetailsViewController {

    func toJoinCourse() -> Void {

        let user_id: Int = 4
        if let course_id = courseIdentifier {
            headerView.joinButtonView.startLoading()
            Request.shared.join(with: user_id, course_id, complitionHandler: { (message) in
                self.headerView.joinButtonView.stopLoading()
                self.display(with: message)
            }) { (message) in
                self.headerView.joinButtonView.stopLoading()
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

        //scroll view
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
    }

    func buildLayouts() -> Void {

        self.add(pagerViewController, onView: coverViewOfPagerView)
        addToScrollView([headerView, coverViewOfPagerView])

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
            self?.toJoinCourse()
        }
    }
}
