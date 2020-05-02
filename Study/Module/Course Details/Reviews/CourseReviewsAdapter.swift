//
//  CourseReviewsAdapter.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class CourseReviewsAdapter: NSObject {

    private var reviews: [Review] = []
    private var totalReviews: Int = 0
    private var currentOffset: Int = 0
    
    weak var delegate: CourseReviewsDelegate?

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseReviewsAdapter")
    }
}

extension CourseReviewsAdapter {

    func appendReviews(with reviews: [Review]) -> Void {
        self.reviews.append(contentsOf: reviews)
    }

    func refreshReviews(with reviews: [Review]) -> Void {
        self.reviews = reviews
        self.currentOffset = 0
    }

    func currentOffset(with value: Int) -> Void {
        self.currentOffset = value
    }

    func totalReviews(with value: Int) -> Void {
        self.totalReviews = value
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseReviewsAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewItem.cellIdentifier(), for: indexPath) as? ReviewItem
        cell?.configure(with: reviews[indexPath.row].text)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == reviews.count - 1 {
            if totalReviews > reviews.count {
                tableView.tableFooterView = LoadMoreSpinnerView()
                tableView.tableFooterView?.isHidden = false
            }
            else{
                tableView.tableFooterView = UIView()
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }

        if totalReviews > reviews.count {
            delegate?.fetchMoreReviews(with: currentOffset)
        }
    }
}

// MARK: - Custom Items

private extension CourseReviewsAdapter {

}
