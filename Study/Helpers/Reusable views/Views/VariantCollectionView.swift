//
//  VariantCollectionView.swift
//  Study
//
//  Created by I on 3/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class VariantCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = CGSize(width: AppSize.Screen.width, height: 100)
        super.init(frame: .zero, collectionViewLayout: layout)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: VariantCollectionView")
    }
}

extension VariantCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VariantItem.cellIdentifier(), for: indexPath) as? VariantItem

        return cell!
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = 20
//    }
}

private extension VariantCollectionView {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        backgroundColor = AppColor.white.uiColor
    }

    func buildServices() -> Void {

        delegate = self
        dataSource = self
        register(VariantItem.self, forCellWithReuseIdentifier: VariantItem.cellIdentifier())
    }
}
