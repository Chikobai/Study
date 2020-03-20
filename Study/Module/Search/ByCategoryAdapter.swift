//
//  ByCategoryAdapter.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


class ByCategoryAdapter: NSObject {

    weak var delegate: ByCategoryDelegate?
    private var courses: [Course] = []

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: ByCategoryAdapter")
    }

    func configure(with courses: [Course]) -> Void {
        self.courses = courses
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

        delegate?.didSelect()
    }
}


// MARK: - Custom Items

private extension ByCategoryAdapter {


}
