//
//  CourseReviewsViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol CourseReviewsScrollDelegate: class {
    
    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView?)
}

protocol CourseReviewsDelegate: class {

    func fetchMoreReviews(with offset: Int) -> Void
}

class CourseReviewsViewController: UITableViewController, FetchableMore {

    var state: State = .empty
    weak var scrollDelegate: CourseReviewsScrollDelegate?
    private var courseIdentifier: Int
    private var adapter: CourseReviewsAdapter = CourseReviewsAdapter()
    private var button = UIButton()

    init(with courseIdentifier: Int) {
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
        Request.shared.loadReviews(with: courseIdentifier, complitionHandler: { (reviews, count) in
            self.button.isHidden = false
            self.refreshControl?.endRefreshing()
            self.state.beginPartFetched = true
            self.adapter.refreshReviews(with: reviews)
            self.adapter.totalReviews(with: count)
            self.tableView.reloadData()
        }) { (message) in
            self.handleError(action: .fetching, with: message)
        }
    }
}

// MARK: - CourseReviewsDelegate

extension CourseReviewsViewController: CourseReviewsDelegate {

    func fetchMoreReviews(with offset: Int) -> Void {
        tableView.backgroundView = nil
        Request.shared.loadMoreReviews(with: courseIdentifier, offset: offset + 1, complitionHandler: { (reviews) in
            self.adapter.appendReviews(with: reviews)
            self.adapter.currentOffset(with: offset + 1)
            self.tableView.reloadData()
            self.tableView.tableFooterView?.isHidden.toggle()
        }) { (message) in
            self.handleError(action: .fetchingMore, with: message)
        }
    }

    @objc
    private func shows(_ sender: UIButton) -> Void {
        let viewController = ReviewViewController(with: courseIdentifier).inNavigate()
        self.present(viewController, animated: true, completion: nil)
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

        //comment button view
        button.isHidden = true
        //table view
        tableView.refreshControl = UIRefreshControl()
        tableView.tableFooterView = UIView()
    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ReviewItem.self, forCellReuseIdentifier: ReviewItem.cellIdentifier())
        button.setTitle(AppTitle.CourseDetails.writeAReview, for: .normal)
        button.setTitleColor(AppColor.systemBlue.uiColor, for: .normal)
        button.addTarget(self, action: #selector(shows), for: .touchUpInside)
        button.frame.size.height = 44.0
        tableView.tableHeaderView = button
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchReviews), for: .valueChanged)
    }
}
