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
    func languageChanged(with message: String) -> Void
}

class SettingsViewController: UITableViewController {

    private let adapter = SettingsAdapter()
    private var imagePickerManager: ImagePicker?

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    private func exitEvent() -> Void {
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

extension SettingsViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) -> Void {

        if let image = image,
            let dataImage = image.jpegData(compressionQuality: 0.001) {
            Request.shared.updateImage(with: dataImage, complitionHandler: { (message) in
                self.display(with: message, completionHandler: { [weak self] in
                    self?.tableView.reloadData()
                })
            }) { (message) in
                self.display(with: message, completionHandler: nil)
            }
        }
    }
}

// MARK: - SettingsDelegate

extension SettingsViewController: SettingsDelegate {

    func didSelected(with item: SettingsItem) {
        switch item {
        case .changableNameItem:
            let viewController = RestoreViewController(with: .changeUsername)
            self.pushWithHidesBottomBar(viewController)
        case .changableEmailItem:
            let viewController = RestoreViewController(with: .restoreEmail)
            self.pushWithHidesBottomBar(viewController)
        case .changablePasswordItem:
            let viewController = RestoreViewController(with: .changePassword)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .exitItem:
            self.exitEvent()
        case .headerItem:
            self.imagePickerManager?.present(from: view)
        default:
            return
        }
    }

    func languageChanged(with message: String) -> Void {
        self.display(with: message, completionHandler: nil)
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

        //image picker
        imagePickerManager = ImagePicker.init(presentationController: self, delegate: self)
    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(SettingsChangableItem.self, forCellReuseIdentifier: SettingsChangableItem.cellIdentifier())
        tableView.register(SettingsHeaderItem.self, forCellReuseIdentifier: SettingsHeaderItem.cellIdentifier())
        tableView.register(SettingsLanguageItem.self, forCellReuseIdentifier: SettingsLanguageItem.cellIdentifier())
    }
}
