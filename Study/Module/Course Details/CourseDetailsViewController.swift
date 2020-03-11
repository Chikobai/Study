//
//  CourseDetailsViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
//import AMScrollingNavbar

protocol CourseDetailsScrollDelegate: class {

    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView)
}

class CourseDetailsViewController: ScrollViewController {

    private var isGoingUp: Bool?
    private var childScrollingDownDueToParent = false

    private lazy var headerView: CourseHeaderView = CourseHeaderView()
    private lazy var coverViewOfPagerView: UIView = UIView()
    private lazy var pagerViewController: CourseDetailsPagerViewController = CourseDetailsPagerViewController()

    init() {
        super.init(nibName: nil, bundle: nil)
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

         self.transparentBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.defaulteBar()
    }
}

extension CourseDetailsViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let navigationBarHeight = self.navigationController?.navigationBar.frame.maxY ?? 0
        let statusBarHeight = self.navigationController?.navigationBar.frame.minY ?? 0
        let parentViewMaxContentYOffset = self.scrollView.contentSize.height - self.scrollView.frame.height

        isGoingUp = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0

        print(statusBarHeight)
        if isGoingUp == true {
            if scrollView.contentOffset.y == parentViewMaxContentYOffset {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                scrollView.contentOffset.y = (parentViewMaxContentYOffset + navigationBarHeight - statusBarHeight)
            }
        }
        else{
            if scrollView.contentOffset.y < abs(statusBarHeight) {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        }
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return false
    }
}

// MARK: - CourseDetailsScrollDelegate

extension CourseDetailsViewController: CourseDetailsScrollDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView) {

        isGoingUp = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0

        let navigationBarHeight = self.navigationController?.navigationBar.frame.maxY ?? 0
        let statusBarHeight = self.navigationController?.navigationBar.frame.minY ?? 0
        let parentViewMaxContentYOffset = self.scrollView.contentSize.height - self.scrollView.frame.height

        print(statusBarHeight)
        if (isGoingUp == true) {
            if scrollView == tableView {
                if self.scrollView.contentOffset.y < parentViewMaxContentYOffset && !childScrollingDownDueToParent {
                    self.scrollView.contentOffset.y = max(min(self.scrollView.contentOffset.y + tableView.contentOffset.y, parentViewMaxContentYOffset), 0)
                    tableView.contentOffset.y = 0
                }
                else{
                    self.navigationController?.setNavigationBarHidden(true, animated: true)

                    let contentOffsetX = self.scrollView.contentOffset.x
                    let contentOffsetY = (parentViewMaxContentYOffset + navigationBarHeight - statusBarHeight)
                    self.scrollView.setContentOffset(CGPoint.init(x: contentOffsetX, y: contentOffsetY), animated: true)
                }
            }
        } else {
            if (scrollView == tableView) {
                if tableView.contentOffset.y < 0 && self.scrollView.contentOffset.y > 0 {

                    self.scrollView.contentOffset.y = max(self.scrollView.contentOffset.y - abs(tableView.contentOffset.y), 0)

                    if self.scrollView.contentOffset.y < abs(statusBarHeight) {
                         navigationController?.setNavigationBarHidden(false, animated: true)
                    }
                }
            }

            if (scrollView == self.scrollView) {
                if tableView.contentOffset.y > 0 && self.scrollView.contentOffset.y < parentViewMaxContentYOffset {
                    childScrollingDownDueToParent = true
                    tableView.contentOffset.y = max(tableView.contentOffset.y - (parentViewMaxContentYOffset - self.scrollView.contentOffset.y) , 0)

                    let contentOffsetX = self.scrollView.contentOffset.x
                    self.scrollView.setContentOffset(CGPoint.init(x: contentOffsetX, y: parentViewMaxContentYOffset), animated: true)

                    childScrollingDownDueToParent = false
                }
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

        //navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false

        //scroll view
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
    }

    func buildLayouts() -> Void {

        self.add(pagerViewController, onView: coverViewOfPagerView)
        addToScrollView([headerView, coverViewOfPagerView])

        let topHeight = self.navigationController?.navigationBar.frame.maxY ?? 0

        headerView.snp.makeConstraints { (make) in
            make.centerX.top.width.equalToSuperview()
            make.height.equalTo(175)
        }

        coverViewOfPagerView.snp.makeConstraints { (make) in
            make.centerX.width.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
            make.height.equalTo(UIScreen.main.bounds.height - topHeight)
        }

    }

    func buildServices() -> Void {

        scrollView.delegate = self
        pagerViewController.scrollDelegate = self
    }
}
