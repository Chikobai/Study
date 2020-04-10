//
//  PagerTabView.swift
//  Study
//
//  Created by I on 4/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class PagerBarView: UIView {

    private(set) var pages: [Category] = [] 
    private var selectedPageItem: Int = 0
    private var barLeadingConstraint: NSLayoutConstraint = NSLayoutConstraint()

    private lazy var barView: UIView = UIView()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()


    init() {
        super.init(frame: .zero)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("DEINIT: PagerBarView")
    }

    func setPages(with value: [Category]) -> Void {
        self.pages = value
        self.collectionView.reloadData()
    }
}

// MARK: - Targets

extension PagerBarView {

    @objc func animatePager(notification: Notification) {
        if let info = notification.userInfo {
            let userInfo = info as! [String: CGFloat]
            self.barLeadingConstraint.constant = self.barView.bounds.width * userInfo["length"]!
            self.selectedPageItem = Int(round(userInfo["length"]!))
            self.layoutIfNeeded()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension PagerBarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageItem.cellIdentifier(), for: indexPath) as? PageItem
        cell?.configure(with: pages[indexPath.item].name_kz)
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if self.selectedPageItem != indexPath.item {
            self.selectedPageItem = indexPath.item
            NotificationCenter.default.post(name: Notification.Name.init(.didSelectPager), object: nil, userInfo: ["index": self.selectedPageItem])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let text = pages[indexPath.item].name_kz
        let cellWidth = text.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 14.0)]).width + 25.0
        return CGSize(width: cellWidth, height: 25.0)
    }
}

// MARK: - Builds

extension PagerBarView {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
        buildNotifications()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .red

        //collection view
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false

        //add subview
        addSubviews(with: [collectionView, barView])
    }

    func buildLayouts() -> Void {

        collectionView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(25)
        }

        barView.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(10)
            make.bottom.equalToSuperview()
        }
    }

    func buildServices() -> Void {

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PageItem.self, forCellWithReuseIdentifier: PageItem.cellIdentifier())
    }

    func buildNotifications() -> Void {

        NotificationCenter.default.addObserver(self, selector: #selector(animatePager), name: Notification.Name(.scrollPager), object: nil)
    }
}
