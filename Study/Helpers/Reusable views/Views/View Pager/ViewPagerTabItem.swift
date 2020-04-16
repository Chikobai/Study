//
//  ViewPagerTabItem.swift
//  Study
//
//  Created by I on 4/15/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class ViewPagerTabItem: UICollectionViewCell {

    private var options: ViewPagerOptions = ViewPagerOptions()
    private var titleLabelView: UILabel = UILabel()
    private var imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: ViewPagerTabItemView")
    }

    func configure(with tab:ViewPagerTab, _ options:ViewPagerOptions) {
        switch options.tabType {
        case ViewPagerTabType.basic:
            titleLabelView.isHidden = false
            titleLabelView.text = tab.title
            imageView.isHidden = true
        case ViewPagerTabType.image:
            imageView.isHidden = false
            imageView.image = tab.image
            titleLabelView.isHidden = true
        }
    }

    func configure(with isSelected: Bool, _ options:ViewPagerOptions) -> Void {
        switch options.tabType {
        case ViewPagerTabType.basic:
            return
        case ViewPagerTabType.image:
            imageView.tintColor = isSelected ?
                options.tabSelectedImageColor : options.tabUnselectedImageColor
        }
    }
}

extension ViewPagerTabItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear

        //title label view
        titleLabelView.textAlignment = .center
        titleLabelView.font = options.tabViewTextFont

        //image view
        imageView.contentMode = .scaleAspectFit
    }

    func buildLayouts() -> Void {

        self.addSubviews(with: [titleLabelView, imageView])

        titleLabelView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(options.tabViewImageSize)
            make.center.equalToSuperview()
        }
    }
}

