//
//  CourseInfoSkillsItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoSkillsItem: UITableViewCell {

    private var items: [String] = []
    
    private lazy var skillsLabelView: UILabel = UILabel()
    private lazy var skillsCollectionView: DynamicHeightCollectionView = {
        let layout = DynamicHeightCollectionViewFlowLayout()
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

    func  configure(with skills: [String]) -> Void {

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
        cell?.configure(with: items[indexPath.item])

        return cell!
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension CourseInfoSkillsItem: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = items[indexPath.item].width(withConstrainedHeight: 34, font: UIFont.systemFont(ofSize: 12.0)) + 20
        return CGSize(width: width, height: 34)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
        skillsLabelView.font = .boldSystemFont(ofSize: 16.0)

        //skills collection view
        skillsCollectionView.backgroundColor = .clear
        skillsCollectionView.showsHorizontalScrollIndicator = false
    }

    func buildLayouts() -> Void {

        addSubviews(with: [skillsLabelView, skillsCollectionView])
        skillsLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.left.equalTo(29.0)
            make.right.equalTo(-29.0)
        }

        skillsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(skillsLabelView.snp.bottom).offset(8.0)
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
            make.bottom.equalTo(-8.0)
        }
    }

    func buildServices() -> Void {
        skillsCollectionView.register(Skilltem.self, forCellWithReuseIdentifier: Skilltem.cellIdentifier())
        skillsCollectionView.delegate = self
        skillsCollectionView.dataSource = self
    }
}
