//
//  CourseInfoController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CourseInfoViewController: UITableViewController, FetchableMore {

    var state: State = .empty

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

        fetchInfo()
    }
}

// MARK: - Targets

extension CourseInfoViewController {

    @objc
    func fetchInfo() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        if let courseIdentifier = courseIdentifier {
            Request.shared.loadInfo(with: courseIdentifier, complitionHandler: { (info) in
                self.refreshControl?.endRefreshing()
                self.state.beginPartFetched = true
                self.adapter.setObject(with: info)
                self.headerView.isHidden = false
                self.tableView.reloadData()
            }) { (message) in
                self.handleError(action: .fetching, with: message)
            }
        }
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
        buildTargets()
    }

    func buildViews() -> Void {

        //scroll view
        headerView.frame.size.height = 200.0
        tableView.refreshControl = UIRefreshControl()
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

    func buildTargets() -> Void {

        tableView.refreshControl?.addTarget(self, action: #selector(fetchInfo), for: .valueChanged)
    }
}
