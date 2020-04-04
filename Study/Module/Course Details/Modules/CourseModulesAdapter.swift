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

final class CourseModulesAdapter: NSObject {

    private var modules: [Module] = []
    private var totalModules: Int = 0
    private var currentOffset: Int = 0

    weak var delegate: CourseModuleDelegate?

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseModulesAdapter")
    }
}

extension CourseModulesAdapter {

    func appendModules(with modules: [Module]) -> Void {
        modules.forEach { (module) in
            module.isCollapsed = true
        }
        self.modules.append(contentsOf: modules)
    }

    func refreshModules(with modules: [Module]) -> Void {
        self.modules = modules
        modules.forEach { (module) in
            module.isCollapsed = true
        }
        self.currentOffset = 0
    }

    func currentOffset(with value: Int) -> Void {
        self.currentOffset = value
    }

    func totalModules(with value: Int) -> Void {
        self.totalModules = value
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseModulesAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return modules.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (modules[section].isCollapsed == true) {
            return 0
        }
        return modules[section].lessons.count
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
            self?.modules[section].isCollapsed?.toggle()
            if let isCollapsed = self?.modules[section].isCollapsed {
                var lessonIndexPaths: [IndexPath] = []
                self?.modules[section].lessons.enumerated().forEach({ (arg0) in
                    let (offset, _) = arg0
                    lessonIndexPaths.append(IndexPath(row: offset, section: section))
                })
                self?.delegate?.toExpand(with: section, isCollapsed, lessonIndexPaths)
            }
        }
        expandableHeaderView.configure(with: modules[section])
        return expandableHeaderView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: LessonItem.cellIdentifier(), for: indexPath) as? LessonItem
        cell?.configure(with: modules[indexPath.section].lessons[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.toRouteLessonDetail(with: modules[indexPath.section].lessons[indexPath.row])
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.row == modules.count - 1 {
            if totalModules > modules.count {
                tableView.tableFooterView = LoadMoreSpinnerView()
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

        if totalModules > modules.count {
            delegate?.fetchMoreModules(with: currentOffset)
        }
    }
}

// MARK: - Custom Items

private extension CourseModulesAdapter {

}
