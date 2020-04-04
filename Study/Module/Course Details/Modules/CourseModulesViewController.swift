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
    
    func toExpand( with section: Int, _ isCollapsed: Bool, _ lessonIndexPaths: [IndexPath]) -> Void
    func fetchMoreModules(with offset: Int) -> Void
    func toRouteLessonDetail(with lesson: Lesson) -> Void
}

class CourseModulesViewController: UITableViewController {

    private var itemInfo: IndicatorInfo?
    private var courseIdentifier: Int?
    private var adapter: CourseModulesAdapter = CourseModulesAdapter()

    weak var scrollDelegate: CourseModulesScrollDelegate?

    init(with itemInfo: IndicatorInfo, _ courseIdentifier: Int) {
        self.itemInfo = itemInfo
        self.courseIdentifier = courseIdentifier
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

        fetchModules()
    }
}

// MARK: - Targets

extension CourseModulesViewController {

    @objc
    func fetchModules() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        if let courseIdentifier = courseIdentifier {
            Request.shared.loadModules(with: courseIdentifier, complitionHandler: { (modules, count) in
                self.refreshControl?.endRefreshing()
                self.adapter.refreshModules(with: modules)
                self.adapter.totalModules(with: count)
                self.tableView.reloadData()
            }) { (message) in
                self.refreshControl?.endRefreshing()
                self.adapter.refreshModules(with: [])
                self.tableView.backgroundView = MessageBackgroundView(with: message)
            }
        }
    }
}

// MARK: - CourseModuleDelegate

extension CourseModulesViewController: CourseModuleDelegate {

    func toExpand(with section: Int, _ isCollapsed: Bool, _ lessonIndexPaths: [IndexPath]) -> Void {
        
        if (isCollapsed == true) {
            tableView.deleteRows(at: lessonIndexPaths, with: .fade)
        } else {
            tableView.insertRows(at: lessonIndexPaths, with: .fade)
        }
    }

    func toRouteLessonDetail(with lesson: Lesson) -> Void {

        let viewController = LessonViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func fetchMoreModules(with offset: Int) -> Void {
        tableView.backgroundView = nil
        if let courseIdentifier = courseIdentifier {
            Request.shared.loadMoreModules(with: courseIdentifier, offset: offset + 1, complitionHandler: { (modules) in
                self.adapter.appendModules(with: modules)
                self.adapter.currentOffset(with: offset + 1)
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden.toggle()
            }) { (message) in
                self.tableView.tableFooterView = nil
                self.display(with: message)
            }
        }
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
        buildTargets()
    }

    func buildViews() -> Void {

        //table view
        tableView.separatorStyle = .none
        tableView.refreshControl = UIRefreshControl()
    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(LessonItem.self, forCellReuseIdentifier: LessonItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchModules), for: .valueChanged)
    }
}
