//
//  SettingsViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {

    func didSelected(with item: SettingsItem) -> Void
}

class SettingsViewController: UITableViewController {

    private let adapter = SettingsAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

// MARK: - SettingsDelegate

extension SettingsViewController: SettingsDelegate {

    func didSelected(with item: SettingsItem) {
        switch item {
        case .changableNameItem:
            let viewController = EditViewController(with: .changeUserName)
            self.pushWithHidesBottomBar(viewController)
        case .changablePhoneItem:
            let viewController = EditViewController(with: .changePhone)
            self.pushWithHidesBottomBar(viewController)
        default:
            return
        }
    }
}

// MARK: - Builds

private extension SettingsViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //table view
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()

        //navigation item
        navigationItem.title = AppTitle.Settings.title

    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(SettingsLanguageItem.self, forCellReuseIdentifier: SettingsLanguageItem.cellIdentifier())
        tableView.register(SettingsChangableItem.self, forCellReuseIdentifier: SettingsChangableItem.cellIdentifier())
        tableView.register(SettingsHeaderItem.self, forCellReuseIdentifier: SettingsHeaderItem.cellIdentifier())
    }
}
