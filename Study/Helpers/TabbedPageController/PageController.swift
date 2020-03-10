//
//  PageController.swift
//  Inviterkz
//
//  Created by Yerassyl Zhassuzakhov on 2/20/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let pages: [UIViewController]
    var scrollAction: ((Int) -> ())?
    var selectedIndex = 0
    
    init(pages: [UIViewController]) {
        self.pages = pages
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                return self.pages.last
            } else {
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                return self.pages[viewControllerIndex + 1]
            } else {
                return self.pages.first
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currentController = pageViewController.viewControllers![0] as? Indexable {
                scrollAction?(currentController.index)
            }
        }
    }
}
