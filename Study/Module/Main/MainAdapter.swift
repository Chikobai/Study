//
//  MainAdapter.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


struct ExpandedLabel {
    var text: String
    var collapsed: Bool
}

class MainAdapter: NSObject {

    private var estimateRowHeightStorage: [IndexPath:CGFloat] = [:]
    private var collapsedRowStorage: [IndexPath] = []
    private var posts: [Post] = []

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: MainAdapter")
    }

    func appendPost(with posts: [Post]) -> Void {
        self.posts.append(contentsOf: posts)
    }

    func newPost(with posts: [Post]) -> Void {
        self.posts = posts
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
        return  UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PostItem.cellIdentifier(), for: indexPath) as? PostItem

        cell?.configure(with: self.posts[indexPath.row], isCollapsed: collapsedRowStorage.contains(indexPath))

        cell?.descriptionLabelGestureNotified = { [weak self] in
            if (self?.collapsedRowStorage.contains(indexPath) == false) {
                self?.collapsedRowStorage.append(indexPath)
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.endUpdates()
            }
        }

        return cell!
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimateRowHeightStorage[indexPath] = cell.frame.size.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
}


// MARK: - Custom Items

private extension MainAdapter {

    
}
