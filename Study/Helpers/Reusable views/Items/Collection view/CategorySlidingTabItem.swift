//
//  PageItem.swift
//  Study
//
//  Created by I on 4/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class CategorySlidingTabItem: UICollectionViewCell {

    private let titleLabelView = UILabel()

    var text: String! {
        didSet {
            titleLabelView.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CategorySlidingTabItem")
    }
}

extension CategorySlidingTabItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear

        //title label view
        titleLabelView.font = UIFont.boldSystemFont(ofSize: 14)

    }

    func buildLayouts() -> Void {

        self.addSubviews(with: [titleLabelView])

        titleLabelView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
