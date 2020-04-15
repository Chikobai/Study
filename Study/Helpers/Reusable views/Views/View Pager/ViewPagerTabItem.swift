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

    private var titleLabelView: UILabel?
    private var imageView: UIImageView?

    var text: String? {
        didSet {
            titleLabelView?.text = text
        }
    }

    var image: UIImage? {
        didSet {
            titleLabelView?.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
            buildBasicTab(with: tab, options)

        case ViewPagerTabType.image:
            buildImageTab(with: tab, options)
        }
    }
}

extension ViewPagerTabItem {

    func buildBasicTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        buildViewsOfBasicTab(with: tab, options)
        buildLayoutsOfBasicTab(with: tab, options)
    }

    func buildViewsOfBasicTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        //superview
        backgroundColor = .clear

        //title label view
        titleLabelView = UILabel()
        titleLabelView?.text = tab.title
        titleLabelView?.textAlignment = .center
        titleLabelView?.font = options.tabViewTextFont
    }

    func buildLayoutsOfBasicTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        self.addSubviews(with: [titleLabelView!])

        titleLabelView?.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

extension ViewPagerTabItem {

    func buildImageTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        buildViewsOfImageTab(with: tab, options)
        buildLayoutsOfImageTab(with: tab, options)
    }

    func buildViewsOfImageTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        //superview
        backgroundColor = .clear

        //image view
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFit
        imageView?.image = tab.image
    }

    func buildLayoutsOfImageTab(
        with tab:ViewPagerTab, _ options:ViewPagerOptions
    ) -> Void {

        self.addSubviews(with: [imageView!])

        imageView?.snp.makeConstraints { (make) in
            make.width.height.equalTo(options.tabViewImageSize)
            make.center.equalToSuperview()
        }
    }
}
