//
//  CourseDetailsPagerViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseDetailsPagerViewController: UIViewController {

    private var courseIdentifier: Int?
    private var options: ViewPagerOptions = ViewPagerOptions()
    private var viewPager:ViewPager?

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseDetailsPagerViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func configure(with courseIdentifier: Int) -> Void {

        self.courseIdentifier = courseIdentifier

        viewPager = ViewPager(containerView: self.view)

        let viewControllers: [UIViewController] = [
            CourseInfoViewController(with: courseIdentifier),
            CourseReviewsViewController(with: courseIdentifier),
            CourseModulesViewController(with: courseIdentifier)
        ]
        let viewPagerTabs: [ViewPagerTab] = [
            ViewPagerTab(title: AppTitle.CourseDetails.info), ViewPagerTab(title: AppTitle.CourseDetails.review), ViewPagerTab(title: AppTitle.CourseDetails.module)
        ]

        viewPager?.setOptions(options: options)
        viewPager?.setTabList(with: viewPagerTabs)
        viewPager?.setTabsViewList(with: viewControllers)
        viewPager?.setCurrentPosition(with: 0)
    }
}
