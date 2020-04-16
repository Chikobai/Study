//
//  CategoryViewController.swift
//  Study
//
//  Created by I on 4/15/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, SearchDrawlable {

    var options: ViewPagerOptions = ViewPagerOptions()
    var viewPager:ViewPager?

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchCategories()
    }
}


// MARK: Configure

extension CategoryViewController {

    func configureViewPager(with categories: [Category]) -> Void {

        viewPager?.setBackground(with: nil)

        var viewControllers = [UIViewController]()
        var viewPagerTabs = [ViewPagerTab]()
        categories.forEach({ (category) in
            let pagerTab = ViewPagerTab(title: category.name_kz)
            viewPagerTabs.append(pagerTab)
            let viewController = ByCategoryViewController(with: category.id)
            viewControllers.append(viewController)
            self.addChild(viewController)
        })

        viewPager?.setOptions(options: options)
        viewPager?.setTabList(with: viewPagerTabs)
        viewPager?.setTabsViewList(with: viewControllers)
        viewPager?.setCurrentPosition(with: 0)
    }
}

// MARK: Targets

extension CategoryViewController {

    @objc
    func searchPressed() -> Void {

        let viewController = SearchViewController()
        self.pushWithHidesBottomBar(viewController)
    }
}


// MARK: Requests

extension CategoryViewController {

    func fetchCategories() -> Void {
        let loadingView = LoadingBackgroundView()
        viewPager?.setBackground(with: loadingView)
        Request.shared.loadCategories(complitionHandler: { (categories) in
            self.configureViewPager(with: categories)
        }) { (message) in
            let retryView = RetryBackgroundView(with: message, retry: {
                self.fetchCategories()
            })
            self.viewPager?.setBackground(with: retryView)
        }
    }
}

