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

    var estimateRowHeightStorage: [IndexPath:CGFloat] = [:]
    private var posts: [ExpandedLabel] = [
        ExpandedLabel(text: "When the user taps the search field of the search bar, isActive is automatically set to true. If the search controller is active and the user has typed something into the search field, the returned data comes from filteredCandies. Otherwise, the data comes from the full list of items. When the user taps the search field of the search bar, isActive is automatically set to true. If the search controller is active and the user has typed something into the search field, the returned data comes from filteredCandies. Otherwise, the data comes from the full list of items.", collapsed: true),
        ExpandedLabel(text: "Remember that the search controller automatically handles showing and hiding the results table, so all your code has to do is provide the correct data (filtered or non-filtered) depending on the state of the controller and whether the user has searched for anything.", collapsed: true),
        ExpandedLabel(text: "When sending information to a detail view controller, you need to ensure the view controller knows which context the user is working with: The full table list or the search results. Here’s how you handle that.When the user taps the search field of the search bar, isActive is automatically set to true. If the search controller is active and the user has typed something into the search field, the returned data comes from filteredCandies. Otherwise, the data comes from the full list of items.", collapsed: true),
        ExpandedLabel(text: "Here, you perform the same isFiltering check as before, but now you’re providing the proper candy object when segueing to the detail view controller. Build and run the code at this point and see how the app now navigates correctly to the detail view from either the main table or the search table with ease.", collapsed: true),
        ExpandedLabel(text: "Build and run the code at this point and see how the app now navigates correctly to the detail view from either the main table or the search table with ease.", collapsed: true),
        ExpandedLabel(text: "Here, you perform the same isFiltering check as before, but now you’re providing the proper candy object when segueing to the detail view controller.When the user taps the search field of the search bar, isActive is automatically set to true. If the search controller is active and the user has typed something into the search field, the returned data comes from filteredCandies. Otherwise, the data comes from the full list of items.", collapsed: true),
    ]

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: MainAdapter")
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

        cell?.configure(with: self.posts[indexPath.row])

        cell?.descriptionLabelGestureNotified = { [weak self] in
            self?.posts[indexPath.row].collapsed.toggle()
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .none)
            tableView.endUpdates()
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
