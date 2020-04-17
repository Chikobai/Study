//
//  TableViewController.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol SubscribedCoursesDelegate: class {
    func toRouteCourseDetails(with course: Course) -> Void
}

class SubscribedCoursesViewController: UITableViewController, FetchableMore, Stylizing {

    var state: State = .empty

    private(set) var adapter: SubscribedCoursesAdapter = SubscribedCoursesAdapter()

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchSubscribedCourses()
    }

    deinit {
        print("DEINIT: SubscribedCoursesViewController")
    }
}

// MARK: - Targets

extension SubscribedCoursesViewController {

    @objc
    func fetchSubscribedCourses() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        Request.shared.loadSubscribedCourses(complitionHandler: { (courses) in
            self.refreshControl?.endRefreshing()
            self.state.beginPartFetched = true
            self.adapter.configure(with: courses)
            self.tableView.reloadData()
        }) { (message) in
            self.handleError(action: .fetching, with: message)
        }
    }
}

// MARK: - SubscribedCoursesDelegate

extension SubscribedCoursesViewController: SubscribedCoursesDelegate {

    func toRouteCourseDetails(with course: Course) -> Void {

        let viewController = CourseDetailsViewController(with: course)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
