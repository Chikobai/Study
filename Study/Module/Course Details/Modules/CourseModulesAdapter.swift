//
//  CourseModulesAdapter.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

struct ExpandableModel {

    var isExpanded: Bool
    let name: String
    let names: [String]
}

class CourseModulesAdapter: NSObject {

    weak var scrollDelegate: CourseModulesScrollDelegate?
    weak var delegate: CourseModuleDelegate?
    private var items: [ExpandableModel] = [
        ExpandableModel.init(isExpanded: true, name: "Introduction to Java", names: ["CourseModulesAdapter", "CourseModulesAdapter", "CourseModulesAdapter"]),
        ExpandableModel.init(isExpanded: true, name: "Introduction to Python", names: ["CourseModulesAdapter", "CourseModulesAdapter", "CourseModulesAdapter"]),
        ExpandableModel.init(isExpanded: true, name: "Introduction to iOS Programming", names: ["CourseModulesAdapter", "CourseModulesAdapter", "CourseModulesAdapter"]),
        ExpandableModel.init(isExpanded: true, name: "Introduction to Android", names: ["CourseModulesAdapter", "CourseModulesAdapter", "CourseModulesAdapter"]),
        ExpandableModel.init(isExpanded: true, name: "Introduction to Kotlin", names: ["CourseModulesAdapter", "CourseModulesAdapter", "CourseModulesAdapter"]),
    ]

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseModulesAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseModulesAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (items[section].isExpanded == false) {
            return 0
        }
        return items[section].names.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return 65.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let expandableHeaderView = ModuleExpandableHeaderView()
        expandableHeaderView.sectionLabelView.text = "\(section + 1)"
        expandableHeaderView.executeTappedEvent = { [weak self] in
            self?.items[section].isExpanded.toggle()
            self?.delegate?.toExpand(with: section, self?.items ?? [])
        }
        return expandableHeaderView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ModuleItem.cellIdentifier(), for: indexPath) as? ModuleItem
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didSelect()
    }
}

// MARK: - UIScrollViewDelegate

extension CourseModulesAdapter: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView: scrollView, tableView: nil)
    }
}


// MARK: - Custom Items

private extension CourseModulesAdapter {

}
