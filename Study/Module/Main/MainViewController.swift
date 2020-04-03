//
//  MainViewController.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol MainDelegate: class {

    func fetchMorePosts(with offset: Int) -> Void
}

class MainViewController: UITableViewController, Stylizing {

    private(set) var adapter: MainAdapter = MainAdapter()

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
        Request.shared.loadPosts(complitionHandler: { (posts, totalPosts) in
            self.refreshControl?.endRefreshing()
            self.adapter.refreshPosts(with: posts)
            self.adapter.totalPosts(with: totalPosts)
            self.adapter.currentOffset(with: 0)
            self.tableView.reloadData()
        }) { (message) in
            self.refreshControl?.endRefreshing()
            self.adapter.refreshPosts(with: [])
            self.tableView.backgroundView = MessageBackgroundView(with: message)
        }
    }
}

extension MainViewController: MainDelegate {

    func fetchMorePosts(with offset: Int) -> Void {
        tableView.backgroundView = nil
        Request.shared.loadMorePosts(offset: offset + 1, complitionHandler: { (posts) in
            self.adapter.appendPosts(with: posts)
            self.adapter.currentOffset(with: offset + 1)
            self.tableView.reloadData()
            self.tableView.tableFooterView?.isHidden.toggle()
        }) { (message) in
            self.tableView.tableFooterView = nil
            self.display(with: message)
        }
    }
}
