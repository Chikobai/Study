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

protocol CourseReviewsDelegate: class {

    func fetchMoreReviews(with offset: Int) -> Void
}

class CourseReviewsViewController: UITableViewController {

    private var courseIdentifier: Int?
    private var itemInfo: IndicatorInfo?
    private var adapter: CourseReviewsAdapter = CourseReviewsAdapter()
    weak var scrollDelegate: CourseReviewsScrollDelegate?


    init(with itemInfo: IndicatorInfo, _ courseIdentifier: Int) {
        self.itemInfo = itemInfo
        self.courseIdentifier = courseIdentifier
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

        fetchReviews()
    }
}

// MARK: - Targets

extension CourseReviewsViewController {

    @objc
    func fetchReviews() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        if let courseIdentifier = courseIdentifier {
            Request.shared.loadReviews(with: courseIdentifier, complitionHandler: { (reviews, count) in
                self.refreshControl?.endRefreshing()
                self.adapter.refreshReviews(with: reviews)
                self.adapter.totalReviews(with: count)
                self.tableView.reloadData()
            }) { (message) in
                self.refreshControl?.endRefreshing()
                self.adapter.refreshReviews(with: [])
                self.tableView.backgroundView = MessageBackgroundView(with: message)
            }
        }
    }
}

// MARK: - CourseReviewsDelegate

extension CourseReviewsViewController: CourseReviewsDelegate {

    func fetchMoreReviews(with offset: Int) -> Void {
        tableView.backgroundView = nil
        if let courseIdentifier = courseIdentifier {
            Request.shared.loadMoreReviews(with: courseIdentifier, offset: offset + 1, complitionHandler: { (reviews) in
                self.adapter.appendReviews(with: reviews)
                self.adapter.currentOffset(with: offset + 1)
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden.toggle()
            }) { (message) in
                self.tableView.tableFooterView = nil
                self.display(with: message)
            }
        }
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
        buildTargets()
    }

    func buildViews() -> Void {

        //table view
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()

    }

    func buildServices() -> Void {

        adapter.delegate = self
        adapter.scrollDelegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ReviewItem.self, forCellReuseIdentifier: ReviewItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchReviews), for: .valueChanged)
    }
}
