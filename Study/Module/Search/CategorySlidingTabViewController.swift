//
//  UISimpleSlidingTabController.swift
//  SlidingTabExample
//
//  Created by Suprianto Djamalu on 03/08/19.
//  Copyright © 2019 Suprianto Djamalu. All rights reserved.
//

import UIKit

class CategorySlidingTabViewController: UIViewController {
    
    private(set) var collectionIndicator = CategorySlidingTabView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private(set) var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    private var items = [UIViewController]()
    private var titles = [String]()

    private var currentPosition = 0
    private let heightHeader = 44

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchCategories()
    }

    func addItem(item: UIViewController, title: String){
        items.append(item)
        titles.append(title)
    }
    
    func setCurrentPosition(position: Int){
        currentPosition = position
        let path = IndexPath(item: currentPosition, section: 0)
        DispatchQueue.main.async {
            self.collectionIndicator.configure(with: path)
            self.collectionIndicator.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            self.collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        }
    }

    deinit {
        print("DEINIT: CategorySlidingTabViewController")
    }
}

// MARK: - UICollectionViewDelegate

extension CategorySlidingTabViewController: UICollectionViewDelegate {

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

extension CategorySlidingTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionIndicator {
            return titles.count
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == collectionIndicator {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySlidingTabItem.cellIdentifier(), for: indexPath) as! CategorySlidingTabItem
            cell.text = titles[indexPath.row]
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UICollectionViewCell.cellIdentifier(), for: indexPath)
            let viewController = items[indexPath.row]
            cell.addSubview(viewController.view)
            viewController.view.frame = cell.frame
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategorySlidingTabViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionIndicator {
            let text = titles[indexPath.item]
            let width = text.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 14)]).width + 10.0
            return CGSize(width: width, height: CGFloat(heightHeader - 10))
        }
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionIndicator {
            return 10
        }
        return 0
    }
}

// MARK: Targets

extension CategorySlidingTabViewController {

    @objc
    func searchPressed() -> Void {

        let viewController = SearchViewController()
        self.pushWithHidesBottomBar(viewController)
    }
}

// MARK: Requests

extension CategorySlidingTabViewController {

    func fetchCategories() -> Void {
        collectionView.backgroundView = LoadingBackgroundView()
        Request.shared.loadCategories(complitionHandler: { (categories) in
            self.collectionView.backgroundView = nil
            categories.forEach({ (category) in
                self.addItem(item: ByCategoryViewController(with: category.id), title: category.name_kz)
            })
            self.collectionIndicator.reloadData()
            self.collectionView.reloadData()
            self.setCurrentPosition(position: 0)
            
        }) { (message) in
            self.collectionView.backgroundView = MessageBackgroundView(with: message)
        }
    }
}

// MARK: - Builds

extension CategorySlidingTabViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

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
            make.height.equalTo(heightHeader)
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
