//
//  PageItem.swift
//  Study
//
//  Created by I on 4/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class PageItem: UICollectionViewCell {

    private lazy var titleLabelView: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: PageItem")
    }

    func configure(with title: String) -> Void {
        titleLabelView.text = title
    }
}

// MARK: - Builds

private extension PageItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //title label view
        titleLabelView.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.textAlignment = .center
    }

    func buildLayouts() -> Void {

        addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
