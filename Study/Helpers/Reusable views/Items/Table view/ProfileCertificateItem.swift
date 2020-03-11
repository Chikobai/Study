//
//  ProfileCertificateItem.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class ProfileCertificateItem: UITableViewCell {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()

    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var previousButtonView: UIButton = UIButton()
    private lazy var nextButtonView: UIButton = UIButton()

    private let verticalPaddingValue: CGFloat = 12.0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        buildFrames()
    }

    deinit {
        print("DEINIT: ProfileCertificateItem")
    }
}

extension ProfileCertificateItem: UICollectionViewDelegate, UICollectionViewDataSource,     UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CertificateItem.cellIdentifier(), for: indexPath) as? CertificateItem
        cell?.backgroundColor = AppColor.main.uiColor
        cell?.layer.cornerRadius = 8

        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 65, height: 45)
    }
}

private extension ProfileCertificateItem {

    @objc
    func previousButtonPressed() -> Void {

        collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .left, animated: true)
    }

    @objc
    func nextButtonPressed() -> Void {

        collectionView.scrollToItem(at: IndexPath.init(row: 9, section: 0), at: .right, animated: true)
    }
}

// MARK: - Builds

private extension ProfileCertificateItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.lightGray.uiColor
        contentView.backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //collection view
        collectionView.backgroundColor = AppColor.white.uiColor
        collectionView.showsHorizontalScrollIndicator = false

        //title label view
        titleLabelView.text = "Certifications"
        titleLabelView.font = .boldSystemFont(ofSize: 14.0)

        //next button view
        nextButtonView.setImage(#imageLiteral(resourceName: "right-chevron 4"), for: .normal)

        //previous button view
        previousButtonView.setImage(#imageLiteral(resourceName: "right-chevron 5"), for: .normal)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, collectionView, nextButtonView, previousButtonView])
        titleLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(12 + verticalPaddingValue)
            make.left.equalTo(45)
        }

        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(titleLabelView.snp.bottom).offset(7)
            make.height.equalTo(60.0)
            make.bottom.equalTo(-12.0)
        }

        previousButtonView.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.right.equalTo(collectionView.snp.left).offset(-5.0)
            make.width.height.equalTo(20.0)
        }

        nextButtonView.snp.makeConstraints { (make) in
            make.centerY.equalTo(collectionView)
            make.left.equalTo(collectionView.snp.right).offset(5.0)
            make.width.height.equalTo(20.0)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: 0, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }

    func buildServices() -> Void {

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CertificateItem.self, forCellWithReuseIdentifier: CertificateItem.cellIdentifier())
    }

    func buildTargets() -> Void {

        previousButtonView.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
        nextButtonView.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
}
