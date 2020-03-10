//
//  CourseModulesViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol CourseModulesScrollDelegate: class {
    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView?)
}

protocol CourseModuleDelegate: class {
    func toExpand(with section: Int, _ items: [ExpandableModel]) -> Void
    func didSelect() -> Void
}

class CourseModulesViewController: UITableViewController {

    private var itemInfo: IndicatorInfo?
    private var adapter: CourseModulesAdapter = CourseModulesAdapter()
    weak var scrollDelegate: CourseModulesScrollDelegate?

    init(with itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseModulesViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

// MARK: - CourseModuleDelegate

extension CourseModulesViewController: CourseModuleDelegate {

    func toExpand(with section: Int, _ items: [ExpandableModel]) -> Void {

        var indexPaths = [IndexPath]()
        for row in items[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        if (items[section].isExpanded == false) {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }

    func didSelect() -> Void {

        let viewController = LessonViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - CourseModulesScrollDelegate

extension CourseModulesViewController: CourseModulesScrollDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView, tableView: UITableView?) {

//        print("FROM MODULES: \(scrollView.contentOffset)")
        scrollDelegate?.scrollViewDidScroll(scrollView: scrollView, tableView: self.tableView)
    }
}


// MARK: - IndicatorInfoProvider

extension CourseModulesViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}

// MARK: - Builds

private extension CourseModulesViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //
    }

    func buildServices() -> Void {

        adapter.delegate = self
        adapter.scrollDelegate = self
        tableView.separatorStyle = .none
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ModuleItem.self, forCellReuseIdentifier: ModuleItem.cellIdentifier())
    }
}
