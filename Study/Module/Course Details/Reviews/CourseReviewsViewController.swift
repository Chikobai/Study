//
//  CourseReviewsViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol CourseReviewsScrollDelegate: class {
    
    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView?)
}

class CourseReviewsViewController: UITableViewController {

    private var itemInfo: IndicatorInfo?
    private var adapter: CourseReviewsAdapter = CourseReviewsAdapter()
    weak var scrollDelegate: CourseReviewsScrollDelegate?


    init(with itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseReviewsViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

// MARK: - CourseReviewsScrollDelegate

extension CourseReviewsViewController: CourseReviewsScrollDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView?) {

//        print("FROM REVIEW: \(scrollView.contentOffset)")
        scrollDelegate?.scrollViewDidScroll(scrollView: scrollView, tableView: self.tableView)
    }
}

// MARK: - IndicatorInfoProvider

extension CourseReviewsViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}

// MARK: - Builds

private extension CourseReviewsViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //scroll view
//        tableView.bounces = false

    }

    func buildServices() -> Void {

        adapter.scrollDelegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ReviewItem.self, forCellReuseIdentifier: ReviewItem.cellIdentifier())
    }
}
