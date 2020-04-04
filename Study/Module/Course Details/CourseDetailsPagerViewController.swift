//
//  CourseDetailsPagerViewController.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CourseDetailsPagerViewController: ButtonBarPagerTabStripViewController {

    private var courseIdentifier: Int?

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

        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = .black
        }
        
        super.viewDidLoad()

        edgesForExtendedLayout = []
    }

    func configure(with courseIdentifier: Int) -> Void {
        self.courseIdentifier = courseIdentifier
        self.reloadPagerTabStripView()
    }
    

    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {

        if let courseIdentifier = courseIdentifier {
            let info = CourseInfoViewController(with: "Info", courseIdentifier)

            let reviews = CourseReviewsViewController(with: "Reviews", courseIdentifier)

            let modules = CourseModulesViewController(with: "Modules", courseIdentifier)

            return [info, reviews, modules]
        }

        return []
    }
}
