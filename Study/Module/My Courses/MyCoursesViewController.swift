//
//  TableViewController.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MyCoursesViewController: UITableViewController, Stylizing {

    private(set) var refreshControlView: UIRefreshControl = UIRefreshControl()
    private(set) var adapter: MyCoursesAdapter = MyCoursesAdapter()

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchSubscribedCourses()
    }

    deinit {
        print("DEINIT: MyCoursesViewController")
    }
}

extension MyCoursesViewController {

    @objc
    func fetchSubscribedCourses() -> Void {
        tableView.backgroundView = nil
        refreshControlView.beginRefreshing()
        Request.shared.loadSubscribedCourses(complitionHandler: { (courses) in
            self.refreshControlView.endRefreshing()
            self.adapter.configure(with: courses)
            self.tableView.reloadData()
        }) { (message) in
            self.refreshControlView.endRefreshing()
            self.tableView.backgroundView = MessageBackgroundView.init()
        }
    }
}
