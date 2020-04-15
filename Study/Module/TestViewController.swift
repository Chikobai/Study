//
//  TestViewController.swift
//  Study
//
//  Created by I on 4/15/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    let tabs: [ViewPagerTab] = [
        ViewPagerTab(title: "First"), ViewPagerTab(title: "Second")
    ]
    var options: ViewPagerOptions = ViewPagerOptions()
    var pager:ViewPager?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red

        pager = ViewPager(containerView: self.view)
        pager?.setOptions(options: options)
        pager?.setTabList(with: [ViewPagerTab(title: "First"), ViewPagerTab(title: "Second")])
        pager?.setTabsViewList(with: [AuthorizationViewController(with: .login), AuthorizationViewController(with: .registration)])
    }
}
