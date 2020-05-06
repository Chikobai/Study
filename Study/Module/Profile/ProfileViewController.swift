//
//  ProfileViewController.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol ProfileDelegate: class {

    func didScroll(with offsetY: CGFloat) -> Void
}

class ProfileViewController: UITableViewController {

    private lazy var headerView: ProfileHeaderView = ProfileHeaderView()
    private let adapter: ProfileAdapter = ProfileAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchProfile()
    }

    deinit {
        print("DEINIT: ProfileViewController")
    }
}

// MARK: - Targets

private extension ProfileViewController {

    @objc
    func settingsBarButtonDidPressed() -> Void {

        let viewController = SettingsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - ProfileDelegate

extension ProfileViewController: ProfileDelegate {

    func didScroll(with offsetY: CGFloat) {

        if (offsetY > -64.0) {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else{
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

// MARK: - Requests

private extension ProfileViewController {

    func fetchProfile() -> Void {
        Request.shared.profile(complitionHandler: { (profile) in
            self.headerView.setProfileObject(with: profile)
            StoreManager.shared().setProfile(with: profile)
        }) { (message) in
            return
        }
    }
}

// MARK: - Builds

private extension ProfileViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.lightGray.uiColor.withAlphaComponent(0.5)

        //header view
        headerView.frame.size.height = 210.byWidth()
        if let profile = StoreManager.shared().profile() {
            headerView.setProfileObject(with: profile)
        }

        //table view
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppColor.lightGray.uiColor.withAlphaComponent(0.5)
        tableView.showsVerticalScrollIndicator = false

        //navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = AppColor.main.uiColor

        //navigation items
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "wheel 1"), style: .plain, target: self, action: #selector(settingsBarButtonDidPressed))
    }

    func buildServices() -> Void {

        tableView.delegate = adapter
        tableView.dataSource = adapter
        adapter.delegate = self
        tableView.register(ProfileStatisticsItem.self, forCellReuseIdentifier: ProfileStatisticsItem.cellIdentifier())
        tableView.register(ProfileNotificationItem.self, forCellReuseIdentifier: ProfileNotificationItem.cellIdentifier())
        tableView.register(ProfileCertificateItem.self, forCellReuseIdentifier: ProfileCertificateItem.cellIdentifier())
        tableView.register(ProfileNotifcationDateItem.self, forCellReuseIdentifier: ProfileNotifcationDateItem.cellIdentifier())
    }
}
