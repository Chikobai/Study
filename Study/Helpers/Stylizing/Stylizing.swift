//
//  Stylizing.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip


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

extension Stylizing where Self: RestorePasswordViewController {

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

extension Stylizing where Self: CategoryViewController {
    
    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        edgesForExtendedLayout = [.bottom, .left, .right]

        //navigation item
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))
    }

    func buildPagers() -> Void {

        settings.style.buttonBarBackgroundColor = AppColor.white.uiColor
        settings.style.buttonBarItemBackgroundColor = AppColor.white.uiColor
        settings.style.selectedBarBackgroundColor = AppColor.main.uiColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
    }

    func buildServices() -> Void {

        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .black
        }
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

extension Stylizing where Self: MyCoursesViewController {

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
        navigationItem.title = "Posts"

        //refresh control
        refreshControl = UIRefreshControl()

        //table view
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
    }

    func buildServices() -> Void {

        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(PostItem.self, forCellReuseIdentifier: PostItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        refreshControl?.addTarget(self, action: #selector(fetchPosts), for: .valueChanged)
    }
}
