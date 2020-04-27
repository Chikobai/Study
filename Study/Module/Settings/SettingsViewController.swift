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

    func exitEvent() -> Void {
        let alertController = UIAlertController(title: AppTitle.Alert.warningMessage, message: AppTitle.Alert.logoutMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AppTitle.Alert.logout, style: .destructive, handler: { (_) in
            self.changeRootToAuthorization()
        }))

        alertController.addAction(UIAlertAction(title: AppTitle.Alert.cancel, style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - SettingsDelegate

extension SettingsViewController: SettingsDelegate {

    func didSelected(with item: SettingsItem) {
        switch item {
        case .changableNameItem:
            let viewController = EditViewController(with: .changeUserName)
            self.pushWithHidesBottomBar(viewController)
        case .changableEmailItem:
            let viewController = RestorePasswordViewController(with: .restoreEmail)
            self.pushWithHidesBottomBar(viewController)
        case .changablePasswordItem:
            let viewController = RestorePasswordViewController(with: .changePassword)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .exitItem:
            self.exitEvent()
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
