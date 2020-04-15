//
//  UISimpleSlidingTabController.swift
//  SlidingTabExample
//
//  Created by Suprianto Djamalu on 03/08/19.
//  Copyright © 2019 Suprianto Djamalu. All rights reserved.
//

import UIKit

class CategorySlidingTabViewController: UIViewController, SearchDrawlable {
    
    private(set) var collectionIndicator = CategorySlidingTabView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private(set) var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    private(set) var slidingTabHeight = 44
    private var currentPosition = 0
    private var lastContentOffsetX: CGFloat = .zero
    
    private var items = [UIViewController]()
    private var titles = [String]()
    private var widthOfIndicators: [CGFloat]{
        get{
            return calculteWidths()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
        fetchCategories()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews \(lastContentOffsetX)")
    }

    private func addItem(item: UIViewController, title: String){
        items.append(item)
        addChild(item)
        titles.append(title)
    }
    
    private func setCurrentPosition(position: Int){
        currentPosition = position
        let path = IndexPath(item: currentPosition, section: 0)
        DispatchQueue.main.async {
            self.collectionIndicator.configure(with: path)
            self.collectionIndicator.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            self.collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
        }
    }

    private func calculteWidths() -> [CGFloat] {

        var widths = [CGFloat]()
        titles.forEach { (title) in
            let width = title.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 14)]).width + 10.0
            widths.append(width)
        }

        return widths
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
            viewController.view.frame = view.bounds
            cell.contentView.addSubview(viewController.view)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategorySlidingTabViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionIndicator {
            if widthOfIndicators.reduce(0, +) > collectionView.frame.width {
                return CGSize(width: widthOfIndicators[indexPath.item], height: CGFloat(slidingTabHeight - 10))
            }
            return CGSize(width: collectionView.frame.width/CGFloat(titles.count), height: CGFloat(slidingTabHeight - 10))
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
            self.collectionView.backgroundView = RetryBackgroundView(with: message, retry: {
                self.fetchCategories()
            })
        }
    }
}

