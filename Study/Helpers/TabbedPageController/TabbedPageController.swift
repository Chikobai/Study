//
//  TabbedPageController.swift
//  Inviterkz
//
//  Created by Yerassyl Zhassuzakhov on 2/20/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

protocol TabBarSelectable {
    var isShown: Bool {get set}
    func selected()
}

typealias TabbedMenuItem = (title: String, controller: TabbedController & Indexable)

class TabbedPageController: UIViewController, TabBarSelectable {

    //    MARK: - Properties

    private var layout = UICollectionViewFlowLayout()
    private let cellId = "cellId"
    private let menuItems: [TabbedMenuItem]

    var isShown: Bool = false
    var selectedIndex = 0

    private var sizes = [CGSize]() {
        didSet {
            layout.invalidateLayout()
        }
    }

    private var pageIndex = 0 {
        didSet {
            tabsCollectionView.selectItem(at: IndexPath(item: pageIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
    }

    lazy var tabsCollectionView: UICollectionView = {
        let tcv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tcv.backgroundColor = .white
        tcv.register(TabCell.self, forCellWithReuseIdentifier: cellId)
        tcv.showsHorizontalScrollIndicator = false
        tcv.dataSource = self
        tcv.delegate = self

        return tcv
    }()

    lazy var pageControllerContainerView: UIView = {
        let pcvc = UIView()

        return pcvc
    }()

    lazy var pageController: PageController = {
        let pages = menuItems.map { $0.controller }
        let pc = PageController(pages: pages)

        return pc
    }()

    //    MARK: - Initialization

    init(menuItems: [TabbedMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(title: "Уведомления", image: #imageLiteral(resourceName: "invisible"), selectedImage: nil)
        setupItemSizes()
        for menuItem in self.menuItems {
            menuItem.controller.tabbedPageController = self
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        setupPageController()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        isShown = false
    }

    //    MARK: - Setup functions

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tabsCollectionView)
        view.addSubview(pageControllerContainerView)
        tabsCollectionView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(40)
        }
        pageControllerContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(tabsCollectionView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
        }
    }

    private func setupCollectionView() {
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        tabsCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    private func setupPageController() {
        pageController.scrollAction = { [unowned self] (index: Int) in
            self.pageIndex = index
        }
        add(pageController, onView: pageControllerContainerView)
    }

    private func setupItemSizes() {
        let screenWidth = UIScreen.main.bounds.width
        let itemsWidth = menuItems.map { $0.title.width(withConstrainedHeight: 40, font: .systemFont(ofSize: 14)) }
        let tabbedCollectionViewWidth = itemsWidth.reduce(0) { $0 + $1 }
        if tabbedCollectionViewWidth < screenWidth  {
            let difference = screenWidth - tabbedCollectionViewWidth
            let adaptedItemSizes = itemsWidth.map { CGSize(width: $0 + difference / CGFloat(menuItems.count), height: 40) }
            self.sizes = adaptedItemSizes
        } else {
            self.sizes = itemsWidth.map { CGSize(width: $0, height: 40) }
        }
    }

    //    MARK: - Simple functions

    func selectVC(at index: Int) {
        assert(index < menuItems.count, "selected index must be less than controllers number")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let direction: UIPageViewController.NavigationDirection = index > self.selectedIndex ? .forward : .reverse
            let vc = self.menuItems[index].controller
            self.pageController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
            self.pageIndex = index
        }
    }

    func setHasNotifications(at index: Int) {
        guard let tabbedCell = tabsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TabCell else { return }
        tabbedCell.setHasNotifications()
    }

    func clearNotifications(at index: Int) {
        guard let tabbedCell = tabsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TabCell else { return }
        tabbedCell.clearNotifications()
    }

    func selected() -> Void {
        if isShown == true && pageController.viewControllers!.count > 0 {
            (pageController.viewControllers![0] as! TabBarSelectable).selected()
        }
        isShown = true
    }
}

extension TabbedPageController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    //    MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizes[indexPath.item]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabCell
        cell.titleLabel.text = menuItems[indexPath.item].title

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let vc = menuItems[indexPath.item].controller
        let index = indexPath.item
        let direction: UIPageViewController.NavigationDirection = index > selectedIndex ? .forward : .reverse
        pageController.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        selectedIndex = index
    }
}
