//
//  ByCategoryViewController.swift
//  Study
//
//  Created by I on 2/23/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol ByCategoryDelegate: class {

    func didSelect() -> Void
}

class ByCategoryViewController: UITableViewController, Stylizing {

    private var itemInfo: IndicatorInfo?
    private(set) var adapter: ByCategoryAdapter = ByCategoryAdapter()

    init(with infoItem: IndicatorInfo){
        self.itemInfo = infoItem
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    deinit {
        print("DEINIT: ByCategoryViewController")
    }
}

extension ByCategoryViewController: ByCategoryDelegate {

    func didSelect() -> Void {
        let viewController = CourseDetailsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - IndicatorInfoProvider

extension ByCategoryViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}
