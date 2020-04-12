//
//  SearchDrawlable.swift
//  Study
//
//  Created by I on 4/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

protocol SearchDrawlable {}

extension SearchDrawlable where Self: CategorySlidingTabViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //navigation item
        navigationItem.title = AppTitle.Category.title
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))

        //navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
        
        //collection indicator view
        (collectionIndicator.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionIndicator.showsHorizontalScrollIndicator = false

        //collection view
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [collectionIndicator, collectionView])

        collectionIndicator.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(slidingTabHeight)
        }

        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(collectionIndicator.snp.bottom)
        }
    }

    func buildServices() -> Void {

        collectionIndicator.register(CategorySlidingTabItem.self, forCellWithReuseIdentifier: CategorySlidingTabItem.cellIdentifier())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifier())
        collectionIndicator.delegate = self
        collectionIndicator.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}
