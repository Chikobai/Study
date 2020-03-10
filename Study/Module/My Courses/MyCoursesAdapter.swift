//
//  MyCoursesAdapter.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


class MyCoursesAdapter: NSObject {

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: MyCoursesAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MyCoursesAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: SubscribedPackageItem.cellIdentifier(), for: indexPath) as? SubscribedPackageItem
        cell?.selectionStyle = .none
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
}


// MARK: - Custom Items

private extension MyCoursesAdapter {


}

