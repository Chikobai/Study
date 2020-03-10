//
//  LessonViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class LessonViewController: BaseButtonBarPagerTabStripViewController<IconableTabItem> {

    let redColor = UIColor(red: 221/255.0, green: 0/255.0, blue: 19/255.0, alpha: 1.0)
    let unselectedIconColor = UIColor(red: 73/255.0, green: 8/255.0, blue: 10/255.0, alpha: 1.0)

    private lazy var shareBarButtonView: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(sharePressedEvent))
    private lazy var infoBarButtonView: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(infoPressedEvent))

    init() {
        super.init(nibName: nil, bundle: nil)
        buttonBarItemSpec = ButtonBarItemSpec.cellClass(width: { (_) -> CGFloat in
            return 50.0
        })
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        buttonBarItemSpec = ButtonBarItemSpec.cellClass(width: { (_) -> CGFloat in
            return 50.0
        })
    }

    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = AppColor.main.uiColor.withAlphaComponent(0.6)
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1.0)
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: IconableTabItem?, newCell: IconableTabItem?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.iconImageView.tintColor = .white
            newCell?.iconImageView.tintColor = self?.unselectedIconColor
        }

        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "Hello, world"
        edgesForExtendedLayout = []
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.rightBarButtonItems = [infoBarButtonView, shareBarButtonView]
    }


    deinit {
        print("DEINIT: LessonViewController")
    }


    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = VideoViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "play-button 1")))
        let child_2 = QuestionsViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "question 6")))
        let child_3 = VideoViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "question 6")))
        let child_4 = VideoViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "book 3")))
        let child_5 = VideoViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "play-button 1")))
        let child_6 = VideoViewController.init(with: IndicatorInfo.init(title: "Video", image: #imageLiteral(resourceName: "book 3")))
        return [child_1, child_2, child_3, child_4, child_5, child_6]
    }

    override func configure(cell: IconableTabItem, for indicatorInfo: IndicatorInfo) {
        cell.iconImageView.image = indicatorInfo.image?.withRenderingMode(.alwaysTemplate)
    }

    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider // swiftlint:disable:this force_cast
            UIView.performWithoutAnimation({ [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfo(for: me).title
            })
        }
    }
}

private extension LessonViewController {

    @objc
    func sharePressedEvent() -> Void {

    }

    @objc
    func infoPressedEvent() -> Void {

    }
}
