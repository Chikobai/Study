//
//  QuestionsViewController.swift
//  Study
//
//  Created by I on 3/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class QuestionsViewController: UIViewController {

    private lazy var variantCollectionView: VariantCollectionView = VariantCollectionView()
    private lazy var questionsLabelView: UILabel = UILabel()
    private var itemInfo: IndicatorInfo?

    init(with itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

}

// MARK: - IndicatorInfoProvider

extension QuestionsViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}

// MARK: - Builds

private extension QuestionsViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //questions label view
        questionsLabelView.font = .boldSystemFont(ofSize: 14)
        questionsLabelView.textAlignment = .center
        questionsLabelView.text = "If you could switch two movie characters, what switch would lead to the most inappropriate movies?"
        questionsLabelView.numberOfLines = 0
        questionsLabelView.sizeToFit()

        //variant collection view

    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [questionsLabelView, variantCollectionView])
        questionsLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
            make.centerX.equalToSuperview()
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
        }

        variantCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(questionsLabelView.snp.bottom).offset(30)
            make.bottom.centerX.width.equalToSuperview()
        }
    }
}
