//
//  VariantCollectionView.swift
//  Study
//
//  Created by I on 3/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class VariantCollectionView: UICollectionView {

    private var variants: [LessonQuestionVariant] = []
    private var alreadyAnsweredForThisQuestion: Bool = false

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

    func configure(with variants: [LessonQuestionVariant]) -> Void {
        self.variants = variants
        self.reloadData()
    }
}

extension VariantCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.variants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VariantItem.cellIdentifier(), for: indexPath) as? VariantItem
        cell?.configure(with: variants[indexPath.row].text)
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (alreadyAnsweredForThisQuestion == false) {
            alreadyAnsweredForThisQuestion.toggle()
            if (variants[indexPath.item].is_true == true) {
                if let cell = collectionView.cellForItem(at: indexPath) as? VariantItem {
                    cell.setCorrect(with: true)
                }
            }
            else{
                if let cell = collectionView.cellForItem(at: indexPath) as? VariantItem {
                    cell.setIncorrect(with: true)
                }

                for (item, variant) in variants.enumerated() {
                    if variant.is_true == true {
                        if let cell = collectionView.cellForItem(at: IndexPath(item: item, section: 0)) as? VariantItem {
                            cell.setCorrect(with: false)
                            return
                        }
                    }
                }
            }
        }
    }
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
