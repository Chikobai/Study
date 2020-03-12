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

    private lazy var editBarButtonItemView: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "pencil 1"), style: .plain, target: self, action: #selector(editBarButtonDidPressed))
    private lazy var settingsBarButtonItemView: UIBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "wheel 1"), style: .plain, target: self, action: #selector(settingsBarButtonDidPressed))
    private lazy var headerView: ProfileHeaderView = ProfileHeaderView()

    private let adapter: ProfileAdapter = ProfileAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

    deinit {
        print("DEINIT: ProfileViewController")
    }
}

private extension ProfileViewController {

    @objc
    func editBarButtonDidPressed() -> Void {

    }

    @objc
    func settingsBarButtonDidPressed() -> Void {

        let viewController = SettingsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

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

// MARK: - Builds

private extension ProfileViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //header view
        headerView.frame.size.height = 230

//      table view
        tableView.tableHeaderView = headerView
        tableView.separatorStyle = .none
        tableView.backgroundColor = AppColor.lightGray.uiColor.withAlphaComponent(0.5)
        tableView.showsVerticalScrollIndicator = false

        //navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = AppColor.main.uiColor

        //navigation items
        navigationItem.rightBarButtonItems = [settingsBarButtonItemView, editBarButtonItemView]
        
    }

    func buildLayouts() -> Void {

    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(ProfileStatisticsItem.self, forCellReuseIdentifier: ProfileStatisticsItem.cellIdentifier())
        tableView.register(ProfileNotificationItem.self, forCellReuseIdentifier: ProfileNotificationItem.cellIdentifier())
        tableView.register(ProfileCertificateItem.self, forCellReuseIdentifier: ProfileCertificateItem.cellIdentifier())
    }
}
