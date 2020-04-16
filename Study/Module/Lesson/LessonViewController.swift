//
//  LessonViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController, LessonDrawlable{

    var options: ViewPagerOptions = ViewPagerOptions()
    var viewPager:ViewPager?
    var moduleIdentifier: Int
    var lessonIdentifier: Int

    init(with moduleIdentifier: Int, _ lessonIdentifier: Int) {
        self.moduleIdentifier = moduleIdentifier
        self.lessonIdentifier = lessonIdentifier
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.isTranslucent = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchLesson()
    }


    deinit {
        print("DEINIT: LessonViewController")
    }
}

// MARK: - Configure

extension LessonViewController {

    func configureViewPager(with pages: [LessonPage]) -> Void {

        viewPager?.setBackground(with: nil)

        var viewControllers = [UIViewController]()
        var viewPagerTabs = [ViewPagerTab]()
        pages.forEach({ (page) in
            let icon = (page.order == 1) ? #imageLiteral(resourceName: "play-button 1") : #imageLiteral(resourceName: "question")
            let pagerTab = ViewPagerTab(image: icon)
            viewPagerTabs.append(pagerTab)
            let viewController: UIViewController = (page.order == 1) ?
                VideoViewController(with: page) : QuestionsViewController(with: page)
            viewControllers.append(viewController)
            self.addChild(viewController)
        })
        options.tabType = .image
        viewPager?.setOptions(options: options)
        viewPager?.setTabList(with: viewPagerTabs)
        viewPager?.setTabsViewList(with: viewControllers)
        viewPager?.setCurrentPosition(with: 0)
    }
}

// MARK: - Targets

extension LessonViewController {

    @objc
    func sharePressedEvent() -> Void {

    }

    @objc
    func infoPressedEvent() -> Void {

    }
}

// MARK: - Request

extension LessonViewController {


    func fetchLesson() -> Void {
        let loadingView = LoadingBackgroundView()
        viewPager?.setBackground(with: loadingView)
        Request.shared.loadLesson(with: moduleIdentifier, lessonIdentifier, complitionHandler: { (pages) in
            self.configureViewPager(with: pages)
        }) { (message) in
            let retryView = RetryBackgroundView(with: message, retry: {
                self.fetchLesson()
            })
            self.viewPager?.setBackground(with: retryView)
        }
    }
}







