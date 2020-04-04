//
//  CourseInfoController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CourseInfoViewController: UITableViewController {

    private var itemInfo: IndicatorInfo?
    private var courseIdentifier: Int?

    private var adapter: CourseInfoAdapter = CourseInfoAdapter()
    private lazy var headerView = CourseInfoHeaderView()

    init(with itemInfo: IndicatorInfo, _ courseIdentifier: Int) {
        self.itemInfo = itemInfo
        self.courseIdentifier = courseIdentifier
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

// MARK: - IndicatorInfoProvider

extension CourseInfoViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}

// MARK: - Builds

private extension CourseInfoViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //scroll view
        headerView.frame.size.height = 200.0
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }

    func buildServices() -> Void {

        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(CourseInfoDescriptionItem.self, forCellReuseIdentifier: CourseInfoDescriptionItem.cellIdentifier())
        tableView.register(CourseInfoTeacherItem.self, forCellReuseIdentifier: CourseInfoTeacherItem.cellIdentifier())
        tableView.register(CourseInfoSkillsItem.self, forCellReuseIdentifier: CourseInfoSkillsItem.cellIdentifier())
        tableView.register(CourseInfoLanguageItem.self, forCellReuseIdentifier: CourseInfoLanguageItem.cellIdentifier())
    }
}
