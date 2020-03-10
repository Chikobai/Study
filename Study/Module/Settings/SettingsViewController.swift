//
//  SettingsViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {

}

class SettingsViewController: UITableViewController {

    private let adapter = SettingsAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
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

        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(SettingsLanguageItem.self, forCellReuseIdentifier: SettingsLanguageItem.cellIdentifier())
        tableView.register(SettingsChangableItem.self, forCellReuseIdentifier: SettingsChangableItem.cellIdentifier())
        tableView.register(SettingsHeaderItem.self, forCellReuseIdentifier: SettingsHeaderItem.cellIdentifier())
    }
}
