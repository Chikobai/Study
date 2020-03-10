//
//  TabBarViewController.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewControllers = makeItems()
        for viewController in viewControllers {
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 9.0, left: 0.0, bottom: -9.0, right: 0.0)
        }

        self.viewControllers = viewControllers


    }
}

private extension TabBarViewController {

    func makeItems() -> [UIViewController] {

        let main = MainViewController().inNavigate()
        main.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "home"), tag: 0)

        let search = CategoryViewController().inNavigate()
        search.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "search"), tag: 1)

        let subscriptions = MyCoursesViewController().inNavigate()
        subscriptions.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "book"), tag: 2)

        let profiles = ProfileViewController().inNavigate()
        profiles.tabBarItem = UITabBarItem.init(title: nil, image: #imageLiteral(resourceName: "avatar"), tag: 3)

        return [main, search, subscriptions, profiles]
    }
}
