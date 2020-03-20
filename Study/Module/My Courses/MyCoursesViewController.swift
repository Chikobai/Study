//
//  TableViewController.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MyCoursesViewController: UITableViewController, Stylizing {

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
        refreshControl?.beginRefreshing()
        Request.shared.loadSubscribedCourses(complitionHandler: { (courses) in
            self.refreshControl?.endRefreshing()
            self.adapter.configure(with: courses)
            self.tableView.reloadData()
        }) { (message) in
            self.refreshControl?.endRefreshing()
            self.tableView.backgroundView = MessageBackgroundView(with: message)
        }
    }
}
