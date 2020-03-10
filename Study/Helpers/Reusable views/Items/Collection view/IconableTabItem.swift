//
//  IconableTabItem.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class IconableTabItem: UICollectionViewCell {

    private(set) lazy var iconImageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: IconableTabItem")
    }
}

private extension IconableTabItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
//        backgroundColor = AppColor.main.uiColor.withAlphaComponent(0.5)

        //icon image view
        iconImageView.backgroundColor = .clear
    }

    func buildLayouts() -> Void {

        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(25)
        }
    }
}
