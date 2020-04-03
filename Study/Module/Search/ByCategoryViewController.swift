//
//  ByCategoryViewController.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol ByCategoryDelegate: class {

    func toRouteCourseDetails(with id: Int) -> Void
    func fetchMoreCourses(with offset: Int) -> Void
}

class ByCategoryViewController: UITableViewController, Stylizing {

    private var itemInfo: IndicatorInfo?
    private(set) var adapter: ByCategoryAdapter = ByCategoryAdapter()

    init(with infoItem: IndicatorInfo){
        self.itemInfo = infoItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchCourses()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    deinit {
        print("DEINIT: ByCategoryViewController")
    }
}

// MARK: - ByCategoryDelegate

extension ByCategoryViewController: ByCategoryDelegate {

    func toRouteCourseDetails(with id: Int) -> Void {
        let viewController = CourseDetailsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func fetchMoreCourses(with offset: Int) -> Void {
        tableView.backgroundView = nil
        Request.shared.loadMoreCourses(offset: offset + 1, complitionHandler: { (courses) in
            self.adapter.appendCourses(with: courses)
            self.adapter.currentOffset(with: offset + 1)
            self.tableView.reloadData()
            self.tableView.tableFooterView?.isHidden.toggle()
        }) { (message) in
            self.tableView.tableFooterView = nil
            self.display(with: message)
        }
    }
}

// MARK: - IndicatorInfoProvider

extension ByCategoryViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}

extension ByCategoryViewController {

    @objc
    func fetchCourses() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        Request.shared.loadCourses(complitionHandler: { (courses, count) in
            self.refreshControl?.endRefreshing()
            self.adapter.refreshCourses(with: courses)
            self.adapter.totalCourses(with: count)
            self.tableView.reloadData()
        }) { (message) in
            self.refreshControl?.endRefreshing()
            self.adapter.refreshCourses(with: [])
            self.tableView.backgroundView = MessageBackgroundView(with: message)
        }
    }
}

