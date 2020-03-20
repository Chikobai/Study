//
//  MainViewController.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol MainDelegate: class {

    func moreLoad() -> Void
}

class MainViewController: UITableViewController, Stylizing {

    private(set) var adapter: MainAdapter = MainAdapter()

    private var limit: Int = 0
    private var offset: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchPosts()
    }

    deinit {
        print("DEINIT: MainViewController")
    }
}

extension MainViewController {

    @objc
    func fetchPosts() -> Void {
        tableView.backgroundView = nil
        refreshControl?.beginRefreshing()
        Request.shared.loadPosts(complitionHandler: { (posts) in
            self.refreshControl?.endRefreshing()
            self.adapter.newPost(with: posts)
            self.tableView.reloadData()
        }) { (message) in
            self.refreshControl?.endRefreshing()
            self.tableView.backgroundView = MessageBackgroundView(with: message)
        }
    }

    @objc
    func fetchMorePosts() -> Void {
        tableView.backgroundView = nil
        Request.shared.loadPosts(complitionHandler: { (posts) in
            self.adapter.appendPost(with: posts)
            self.tableView.reloadData()
        }) { (message) in
            self.tableView.backgroundView = UILabel()
        }
    }
}
