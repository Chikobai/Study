//
//  ByCategoryAdapter.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


final class ByCategoryAdapter: NSObject {

    private var courses: [Course] = []
    private var totalCourses: Int = 0
    private var currentOffset: Int = 0

    weak var delegate: ByCategoryDelegate?

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: ByCategoryAdapter")
    }
}

extension ByCategoryAdapter {

    func appendCourses(with courses: [Course]) -> Void {
        self.courses.append(contentsOf: courses)
    }

    func refreshCourses(with courses: [Course]) -> Void {
        self.courses = courses
    }

    func currentOffset(with value: Int) -> Void {
        self.currentOffset = value
    }

    func totalCourses(with value: Int) -> Void {
        self.totalCourses = value
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ByCategoryAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PackageItem.cellIdentifier(), for: indexPath) as? PackageItem
        cell?.configure(with: courses[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.toRouteCourseDetails(with: courses[indexPath.row].id)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == courses.count - 1 {
            if totalCourses > courses.count {
                tableView.tableFooterView = SpinnerView()
                tableView.tableFooterView?.isHidden = false
            }
            else{
                tableView.tableFooterView = nil
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }

        if totalCourses > courses.count {
            delegate?.fetchMoreCourses(with: currentOffset)
        }
    }
}


// MARK: - Custom Items

private extension ByCategoryAdapter {


}
