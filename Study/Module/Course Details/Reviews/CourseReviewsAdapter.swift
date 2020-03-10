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

    weak var scrollDelegate: CourseReviewsScrollDelegate?
    private var items: [String] = [
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable.",
        "Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable. Examples of structures that are discrete are combinations, graphs, and logical statements. Discrete structures can be finite or infinite.Discrete mathematics is the study of mathematical structures that are countable or otherwise distinct and separable."
    ]

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseReviewsAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseReviewsAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MessageHeaderView(with: AppTitle.CourseDetails.reviewsMessage)
        return header
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewItem.cellIdentifier(), for: indexPath) as? ReviewItem
        cell?.configure(with: items[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - UIScrollViewDelegate

extension CourseReviewsAdapter: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView: scrollView, tableView: nil)
    }
}

// MARK: - Custom Items

private extension CourseReviewsAdapter {

}
