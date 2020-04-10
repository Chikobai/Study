//
//  CategoryViewController.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CategoryViewController: UISlidingTabController, Stylizing {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = AppTitle.Category.title
        build()
        addItem(item: ByCategoryViewController(with: "", 1), title: "Geometry")
        addItem(item: ByCategoryViewController(with: "", 1), title: "Biology")
        addItem(item: ByCategoryViewController(with: "", 1), title: "Phisics")
        addItem(item: ByCategoryViewController(with: "", 1), title: "Algebra")
        addItem(item: ByCategoryViewController(with: "", 1), title: "History")
        addItem(item: ByCategoryViewController(with: "", 1), title: "English")
        addItem(item: ByCategoryViewController(with: "", 1), title: "Russian")
        buildSlidingTab()
        fetchCategories()
    }

    deinit {
        print("DEINIT: CategoryViewController")
    }
}

// MARK: Request

extension CategoryViewController {

    func fetchCategories() -> Void {
        Request.shared.loadCategories(complitionHandler: { (categories) in
//            self.backgroundView = nil

        }) { (message) in
//            self.collectionView.backgroundView = MessageBackgroundView(with: message)
        }
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
