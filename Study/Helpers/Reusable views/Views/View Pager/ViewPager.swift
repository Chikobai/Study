//
//  ViewPager.swift
//  Study
//
//  Created by I on 4/15/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class ViewPager: NSObject {

    private lazy var view: UIView = UIView()
    private lazy var tabView = ViewPagerTabView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    private var tabsList = [ViewPagerTab]()
    private var tabsViewList = [UIViewController]()

    private var options = ViewPagerOptions()
    private var currentPosition = 0
    private var widthOfIndicators: [CGFloat]{
        get{
            return calculteWidths()
        }
    }

    public init(containerView: UIView) {
        super.init()
        self.view = containerView
        build()
    }

    public func setOptions(options: ViewPagerOptions) {
        self.options = options
    }

    public func setTabList(with tabsList: [ViewPagerTab]) {
        self.tabsList = tabsList
        self.tabView.reloadData()
    }

    public func setTabsViewList(with tabsViewList: [UIViewController]) {
        self.tabsViewList = tabsViewList
        self.collectionView.reloadData()
    }

    public func setBackground(with backgroundView: UIView?) {
        self.collectionView.backgroundView = backgroundView
    }

    public func setCurrentPosition(with position: Int) {
        setCurrentPosition(position: currentPosition)
    }
}

// MARK: - Private Methods

extension ViewPager {

    private  func setCurrentPosition(position: Int){
        if tabsList.count > position {
            currentPosition = position
            let path = IndexPath(item: currentPosition, section: 0)
            DispatchQueue.main.async {
                self.tabView.configure(with: path)
                self.tabView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
                self.collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
                self.tabView.reloadData()
            }
        }
    }

    private  func calculteWidths() -> [CGFloat] {

        var widths = [CGFloat]()

        if options.tabType == .basic {
            tabsList.forEach { (tab) in
                let width: CGFloat = tab.title?.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 14)]).width ?? .zero + 10.0
                widths.append(width)
            }
        }
        return widths
    }
}

// MARK: - UICollectionViewDelegate

extension ViewPager: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCurrentPosition(position: indexPath.row)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let currentIndex = Int(self.collectionView.contentOffset.x / collectionView.frame.size.width)
            setCurrentPosition(position: currentIndex)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension ViewPager: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabView {
            return tabsList.count
        }
        return tabsViewList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == tabView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewPagerTabItem.cellIdentifier(), for: indexPath) as! ViewPagerTabItem
            let isSelected = (indexPath.row == currentPosition)
            cell.configure(with: tabsList[indexPath.row], options)
            cell.configure(with: isSelected, options)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.cellIdentifier(), for: indexPath)
            let viewController = tabsViewList[indexPath.row]
            viewController.view.frame = view.bounds
            cell.contentView.addSubview(viewController.view)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewPager: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabView {
            if widthOfIndicators.reduce(0, +) > collectionView.frame.width {
                return CGSize(width: widthOfIndicators[indexPath.item], height: CGFloat(options.tabViewHeight - 10))
            }
            return CGSize(width: collectionView.frame.width / CGFloat(tabsList.count), height: CGFloat(options.tabViewHeight - 10))
        }
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == tabView {
            return 10
        }
        return 0
    }
}


extension ViewPager {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //tab view
        tabView.backgroundColor = .white
        tabView.showsHorizontalScrollIndicator = false
        (tabView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal

        //collection view
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [tabView, collectionView])

        tabView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(options.tabViewHeight)
        }

        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(tabView.snp.bottom)
        }
    }

    func buildServices() -> Void {

        tabView.register(ViewPagerTabItem.self, forCellWithReuseIdentifier: ViewPagerTabItem.cellIdentifier())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifier())

        tabView.delegate = self
        tabView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}





