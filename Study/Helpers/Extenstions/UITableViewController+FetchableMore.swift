//
//  UIViewController+FetchableMore.swift
//  Study
//
//  Created by I on 4/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

struct State {
    var beginPartFetched: Bool
    static let empty = State(beginPartFetched: false)
}

enum Action {
    case fetching
    case fetchingMore
}

protocol FetchableMore {
    var state: State { get set }
}

extension FetchableMore where Self: UITableViewController {

    func handleError(action: Action, with message: String) -> Void {
        switch action {
        case .fetching:
            self.refreshControl?.endRefreshing()
            guard state.beginPartFetched == false else  {
                self.display(with: message)
                return
            }
            tableView.backgroundView = MessageBackgroundView(with: message)
        case .fetchingMore:
            self.tableView.tableFooterView = nil
            self.display(with: message)
        }
    }
}
