//
//  ByCategoryViewController.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol ByCategoryDelegate: class {

    func toRouteCourseDetails(with course: Course) -> Void
    func fetchMoreCourses(with offset: Int) -> Void
}

class ByCategoryViewController: UITableViewController, FetchableMore, Stylizing {

    var state: State = .empty
    private var categoryIdentifier: Int?
    private(set) var adapter: ByCategoryAdapter = ByCategoryAdapter()

    init(with categoryIdentifier: Int){
        super.init(nibName: nil, bundle: nil)
        self.categoryIdentifier = categoryIdentifier
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

// MARK: - Targets

extension ByCategoryViewController {

    @objc
    func fetchCourses() -> Void {
        if let categoryIdentifier = categoryIdentifier {
            tableView.backgroundView = nil
            refreshControl?.beginRefreshing()
            Request.shared.loadCourses(with: categoryIdentifier, complitionHandler: { (courses, count) in
                self.refreshControl?.endRefreshing()
                self.state.beginPartFetched = true
                self.adapter.refreshCourses(with: courses)
                self.adapter.totalCourses(with: count)
                self.tableView.reloadData()
            }) { (message) in
                self.handleError(action: .fetching, with: message)
            }
        }
    }
}

// MARK: - ByCategoryDelegate

extension ByCategoryViewController: ByCategoryDelegate {

    func toRouteCourseDetails(with course: Course) -> Void {
        let viewController = CourseDetailsViewController(with: course)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func fetchMoreCourses(with offset: Int) -> Void {
        if let categoryIdentifier = categoryIdentifier {
            tableView.backgroundView = nil
            Request.shared.loadMoreCourses(with: categoryIdentifier, offset + 1, complitionHandler: { (courses) in
                self.adapter.appendCourses(with: courses)
                self.adapter.currentOffset(with: offset + 1)
                self.tableView.reloadData()
                self.tableView.tableFooterView?.isHidden.toggle()
            }) { (message) in
                self.handleError(action: .fetchingMore, with: message)
            }
        }
    }
}


