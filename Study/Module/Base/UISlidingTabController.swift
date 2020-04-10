//
//  UISimpleSlidingTabController.swift
//  SlidingTabExample
//
//  Created by Suprianto Djamalu on 03/08/19.
//  Copyright © 2019 Suprianto Djamalu. All rights reserved.
//

import UIKit

class UISlidingTabController: UIViewController {
    
    private let collectionIndicator = SlidingTabView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    private let collectionHeaderIdentifier = "COLLECTION_HEADER_IDENTIFIER"
    private let collectionPageIdentifier = "COLLECTION_PAGE_IDENTIFIER"
    private var items = [UIViewController]()
    private var titles = [String]()
    private var colorHeaderActive = AppColor.black.uiColor
    private var colorHeaderInActive = AppColor.black.uiColor
    private var colorHeaderBackground = UIColor.white
    private var currentPosition = 0
    private let heightHeader = 44
    
    func addItem(item: UIViewController, title: String){
        items.append(item)
        titles.append(title)
    }
    
    func setHeaderBackgroundColor(color: UIColor){
        colorHeaderBackground = color
    }
    
    func setHeaderActiveColor(color: UIColor){
        colorHeaderActive = color
    }
    
    func setHeaderInActiveColor(color: UIColor){
        colorHeaderInActive = color
    }
    
    func setCurrentPosition(position: Int){
        currentPosition = position
        let path = IndexPath(item: currentPosition, section: 0)
        DispatchQueue.main.async {
            self.collectionIndicator.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            self.collectionView.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
            self.collectionIndicator.reloadData()
        }
    }
    
    func buildSlidingTab(){

        // view
       view.addSubviews(with: [collectionIndicator, collectionView])
        
        // collectionHeader
        collectionIndicator.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(heightHeader)
        }
        (collectionIndicator.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionIndicator.showsHorizontalScrollIndicator = false
        collectionIndicator.register(SlidingTabItem.self, forCellWithReuseIdentifier: collectionHeaderIdentifier)
        collectionIndicator.delegate = self
        collectionIndicator.dataSource = self
        collectionIndicator.reloadData()
        
        // collectionPage
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(collectionIndicator.snp.bottom)
        }
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionPageIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension UISlidingTabController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCurrentPosition(position: indexPath.row)
        if let cell = collectionIndicator.cellForItem(at: indexPath) {
            collectionIndicator.leftConstraintOfIndicator.constant = cell.frame.minX
            self.collectionIndicator.widthConstraintOfIndicator.constant = cell.frame.width
            UIView.animate(withDuration: 0.5) {
                self.collectionIndicator.layoutIfNeeded()
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let currentIndex = Int(self.collectionView.contentOffset.x / collectionView.frame.size.width)
            setCurrentPosition(position: currentIndex)
            if let cell = collectionIndicator.cellForItem(at: IndexPath(row: currentIndex, section: 0)) {
                collectionIndicator.leftConstraintOfIndicator.constant = cell.frame.minX
                self.collectionIndicator.widthConstraintOfIndicator.constant = cell.frame.width
                UIView.animate(withDuration: 0.5) {
                    self.collectionIndicator.layoutIfNeeded()
                }
            }
        }
    }
}

extension UISlidingTabController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionIndicator {
            return titles.count
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionIndicator {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionHeaderIdentifier, for: indexPath) as! SlidingTabItem
            cell.text = titles[indexPath.row]
            
            var didSelect = false
            
            if currentPosition == indexPath.row {
                didSelect = true
            }
            
            cell.select(didSelect: didSelect, activeColor: colorHeaderActive, inActiveColor: colorHeaderInActive)
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionPageIdentifier, for: indexPath)
        let vc = items[indexPath.row]
        cell.addSubview(vc.view)

        vc.view.frame = cell.frame

        return cell
    }
}

extension UISlidingTabController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionIndicator {
            let text = titles[indexPath.item]
            let width = text.size(withAttributes:[.font: UIFont.boldSystemFont(ofSize: 18)]).width + 30.0
            return CGSize(width: width, height: CGFloat(heightHeader - 10))
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionIndicator {
            return 10
        }
        
        return 0
    }
}

private class SlidingTabView: UICollectionView {

    lazy var indicatorView: UIView = UIView()

    var leftConstraintOfIndicator: NSLayoutConstraint!
    var widthConstraintOfIndicator: NSLayoutConstraint!

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: SlidingTabView")
    }
}

extension SlidingTabView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //indicator view
        indicatorView.backgroundColor = AppColor.main.uiColor
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
    }

    func buildLayouts() -> Void {

        leftConstraintOfIndicator = indicatorView.leftAnchor.constraint(equalTo: leftAnchor)
        widthConstraintOfIndicator = indicatorView.widthAnchor.constraint(equalToConstant: 100)

        addSubviews(with: [indicatorView])
        NSLayoutConstraint.activate([
            leftConstraintOfIndicator,
            widthConstraintOfIndicator,
            indicatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 3.0),
        ])
    }
}

private class SlidingTabItem: UICollectionViewCell {

    private let titleLabelView = UILabel()

    var text: String! {
        didSet {
            titleLabelView.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func select(didSelect: Bool, activeColor: UIColor, inActiveColor: UIColor){
        if didSelect {
            titleLabelView.textColor = activeColor
        }else{
            titleLabelView.textColor = inActiveColor
        }
    }

    deinit {
        print("DEINIT: SlidingTabItem")
    }
}

extension SlidingTabItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear

        //title label view
        titleLabelView.font = UIFont.boldSystemFont(ofSize: 18)

    }

    func buildLayouts() -> Void {

         self.addSubviews(with: [titleLabelView])

        titleLabelView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}
