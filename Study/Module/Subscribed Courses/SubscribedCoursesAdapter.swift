//
//  MyCoursesAdapter.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


class SubscribedCoursesAdapter: NSObject {

    weak var delegate: SubscribedCoursesDelegate?
    private var courses: [SubscribedCourse] = []

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: MyCoursesAdapter")
    }

    func configure(with courses: [SubscribedCourse]) -> Void {
        self.courses = courses
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SubscribedCoursesAdapter: UITableViewDelegate, UITableViewDataSource {

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

        let cell = tableView.dequeueReusableCell(withIdentifier: SubscribedPackageItem.cellIdentifier(), for: indexPath) as? SubscribedPackageItem
        cell?.configure(with: courses[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.toRouteCourseDetails(with: courses[indexPath.row])
    }
}


// MARK: - Custom Items

private extension SubscribedCoursesAdapter {


}

