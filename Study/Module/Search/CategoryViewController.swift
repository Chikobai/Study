//
//  CategoryViewController.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CategoryViewController: ButtonBarPagerTabStripViewController, Stylizing {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        buildPagers()
        super.viewDidLoad()
        build()
    }

    deinit {
        print("DEINIT: CategoryViewController")
    }

    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        navigationItem.title = AppTitle.Category.title

        let child_1 = ByCategoryViewController(with: "Chemistry")
        let child_2 = ByCategoryViewController(with: "Math")
        let child_3 = ByCategoryViewController(with: "Programming")
        let child_4 = ByCategoryViewController(with: "Biology")
        let child_5 = ByCategoryViewController(with: "Geometry")
        let child_6 = ByCategoryViewController(with: "Algebra")
        let child_7 = ByCategoryViewController(with: "Economica")
        let child_8 = ByCategoryViewController(with: "Geography")

        return [child_1, child_2, child_3, child_4, child_5, child_6, child_7, child_8]
    }
}

extension CategoryViewController {

    @objc
    func searchPressed() -> Void {

        self.hidesBottomBarWhenPushed = true
        let viewController = SearchViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}



