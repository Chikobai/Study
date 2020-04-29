//
//  CourseInfoSkillsItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoSkillsItem: UITableViewCell {

    private var items: [CourseSkill] = []
    
    private lazy var skillsLabelView: UILabel = UILabel()
    lazy var skillsCollectionView: DynamicHeightCollectionView = {
        let layout = DynamicHeightCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize.init(width: 1, height: 1)
        let view = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoSkillsItem")
    }

    func  configure(with skills: [CourseSkill]) -> Void {

        self.items = skills
        skillsCollectionView.reloadData()
        skillsCollectionView.layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDelegate

extension CourseInfoSkillsItem: UICollectionViewDelegate{

}

// MARK: - UICollectionViewDataSource

extension CourseInfoSkillsItem: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Skilltem.cellIdentifier(), for: indexPath) as? Skilltem
        cell?.configure(with: items[indexPath.item].name)

        return cell!
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseInfoSkillsItem: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let text = items[indexPath.item].name
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.byWidth())]).width + 30.byWidth()
        return CGSize(width: cellWidth, height: 30.byWidth())
    }
}

// MARK: - Builds

private extension CourseInfoSkillsItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //skills label view
        skillsLabelView.text = "Skills you will gain:"
        skillsLabelView.numberOfLines =  2
        skillsLabelView.font = .boldSystemFont(ofSize: 16.byWidth())

        //skills collection view
        skillsCollectionView.backgroundColor = .clear
        skillsCollectionView.showsHorizontalScrollIndicator = false
    }

    func buildLayouts() -> Void {

        addSubviews(with: [skillsCollectionView])

        skillsCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    func buildServices() -> Void {
        skillsCollectionView.register(Skilltem.self, forCellWithReuseIdentifier: Skilltem.cellIdentifier())
        skillsCollectionView.delegate = self
        skillsCollectionView.dataSource = self
    }
}
