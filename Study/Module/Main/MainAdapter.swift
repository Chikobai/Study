//
//  MainAdapter.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit
import ReadMoreTextView

class MainAdapter: NSObject {

    private var estimateRowHeightStorage: [IndexPath:CGFloat] = [:]
    private var collapsedRowStorage = Set<Int>()
    private var posts: [Post] = []
    private var totalPosts: Int = 0
    private var currentOffset: Int = 0

    weak var  delegate: MainDelegate?

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: MainAdapter")
    }
}

extension MainAdapter {

    func appendPosts(with posts: [Post]) -> Void {
        self.posts.append(contentsOf: posts)
    }

    func refreshPosts(with posts: [Post]) -> Void {
        self.posts = posts
        self.currentOffset = 0
    }

    func currentOffset(with value: Int) -> Void {
        self.currentOffset = value
    }

    func totalPosts(with value: Int) -> Void {
        self.totalPosts = value
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let estimatedHeight = estimateRowHeightStorage[indexPath] {
            return estimatedHeight
        }
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PostItem.cellIdentifier(), for: indexPath) as? PostItem
        let isCollapsed = collapsedRowStorage.contains(indexPath.row)
        cell?.configure(with: self.posts[indexPath.row], isCollapsed)

        return cell!
    }


    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        estimateRowHeightStorage[indexPath] = cell.frame.size.height

        if indexPath.row == posts.count - 1 {
            if totalPosts > posts.count {
                tableView.tableFooterView = LoadMoreSpinnerView()
                tableView.tableFooterView?.isHidden = false
            }
            else{
                tableView.tableFooterView = nil
            }
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if collapsedRowStorage.contains(indexPath.row) {
            collapsedRowStorage.remove(indexPath.row)
        }
        else{
            collapsedRowStorage.insert(indexPath.row)
        }

        tableView.performBatchUpdates({
            tableView.reloadRows(at: [indexPath], with: .none)
        }, completion: nil)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard
            (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height else { return }

        if totalPosts > posts.count {
            delegate?.fetchMorePosts(with: currentOffset)
        }
    }
}


// MARK: - Custom Items

private extension MainAdapter {

    
}
