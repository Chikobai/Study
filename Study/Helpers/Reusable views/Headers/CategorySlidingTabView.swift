//
//  PagerTabView.swift
//  Study
//
//  Created by I on 4/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CategorySlidingTabView: UICollectionView {

    lazy var indicatorView: UIView = UIView()

    var leftConstraintOfIndicator: NSLayoutConstraint!
    private var widthConstraintOfIndicator: NSLayoutConstraint!

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CategorySlidingTabView")
    }

    func configure(with path: IndexPath) -> Void {
        if let cell = self.cellForItem(at: path) {
            self.leftConstraintOfIndicator.constant = cell.frame.minX
            self.widthConstraintOfIndicator.constant = cell.frame.width
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}

extension CategorySlidingTabView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //indicator view
        indicatorView.backgroundColor = AppColor.main.uiColor
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
    }

    func buildLayouts() -> Void {

        leftConstraintOfIndicator = indicatorView.leftAnchor.constraint(equalTo: leftAnchor)
        widthConstraintOfIndicator = indicatorView.widthAnchor.constraint(equalToConstant: 0)

        addSubviews(with: [indicatorView])
        NSLayoutConstraint.activate([
            leftConstraintOfIndicator,
            widthConstraintOfIndicator,
            indicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 2.0),
            ])
    }
}
