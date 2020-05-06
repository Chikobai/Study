//
//  Stylizing.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit


protocol Stylizing {}


extension Stylizing where Self: AuthorizationViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = .white

        //table view
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none

        //navigation controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }

    func buildServices() -> Void {

        adapter?.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(FloatingTextFieldItem.self, forCellReuseIdentifier: FloatingTextFieldItem.cellIdentifier())
        tableView.register(FilledButtonItem.self, forCellReuseIdentifier: FilledButtonItem.cellIdentifier())
        tableView.register(DefaultButtonItem.self, forCellReuseIdentifier: DefaultButtonItem.cellIdentifier())
        tableView.register(OTPItem.self, forCellReuseIdentifier: OTPItem.cellIdentifier())
        tableView.register(MessageItem.self, forCellReuseIdentifier: MessageItem.cellIdentifier())
    }
}

extension Stylizing where Self: RestoreViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = .white

        //table view
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()

        //navigation controller
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }

    func buildServices() -> Void {

        adapter?.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(FloatingTextFieldItem.self, forCellReuseIdentifier: FloatingTextFieldItem.cellIdentifier())
        tableView.register(FilledButtonItem.self, forCellReuseIdentifier: FilledButtonItem.cellIdentifier())
        tableView.register(OTPItem.self, forCellReuseIdentifier: OTPItem.cellIdentifier())
        tableView.register(MessageItem.self, forCellReuseIdentifier: MessageItem.cellIdentifier())
    }
}

extension Stylizing where Self: SearchViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor
        extendedLayoutIncludesOpaqueBars = true

        //search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter name of courses"
        definesPresentationContext = true

        //table view
        tableView.separatorStyle = .none

        //navigation item
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = AppTitle.Search.title

        //navigation bar
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    func buildServices() -> Void {

        tableView.register(PackageItem.self, forCellReuseIdentifier: PackageItem.cellIdentifier())
    }
}

extension Stylizing where Self: ByCategoryViewController {

    func build() -> Void {

        buildViews()
        buildServices()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //table view
        tableView.contentInset = .bottom(with: 50)

        //refresh control
        refreshControl = UIRefreshControl()
    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(PackageItem.self, forCellReuseIdentifier: PackageItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchCourses), for: .valueChanged)
    }
}

extension Stylizing where Self: SubscribedCoursesViewController {

    func build() -> Void {

        buildViews()
        buildServices()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //navigation item
        navigationItem.title = AppTitle.MyCourses.title

        //refresh control
        refreshControl = UIRefreshControl()

    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(SubscribedPackageItem.self, forCellReuseIdentifier: SubscribedPackageItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchSubscribedCourses), for: .valueChanged)
    }
}


extension Stylizing where  Self: MainViewController {

    func build() -> Void {

        buildViews()
        buildServices()
        buildTargets()
    }

    func buildViews() -> Void {

        //navigation item
        navigationItem.title = AppTitle.Main.news

        //refresh control
        refreshControl = UIRefreshControl()

        //table view
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
    }

    func buildServices() -> Void {

        adapter.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(PostItem.self, forCellReuseIdentifier: PostItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
    }
}
