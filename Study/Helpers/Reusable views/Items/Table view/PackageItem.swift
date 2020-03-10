//
//  PackageItem.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class PackageItem: UITableViewCell {

    private var verticalPadding: CGFloat = 25
    private var horizontalPadding: CGFloat = 11

    private lazy var packageIconView: UIImageView = UIImageView()
    private(set) lazy var packageNameLabelView: UILabel = UILabel()
    private lazy var reviewButtonView: UIButton = UIButton()
    private lazy var communityView: IconableLabelView = IconableLabelView()
    private lazy var lessonsView: IconableLabelView = IconableLabelView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        buildFrames()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: PackageItem")
    }
}

// MARK: - Targets

private extension PackageItem {

    @objc
    func reviewPressed() -> Void {
        print("reviewPressed")
    }
}

// MARK: - Builds

private extension PackageItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //content view
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 0.2
        contentView.layer.borderColor = AppColor.lightGray.cgColor

        //content view shadow
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 0.24
        contentView.layer.shadowRadius = CGFloat(1)

        //package name label view
        packageNameLabelView.text = "Discrete mathematics"
        packageNameLabelView.font = UIFont.systemFont(ofSize: 20)
        packageNameLabelView.numberOfLines = 2

        //review button view
        reviewButtonView.layer.cornerRadius = 14
        reviewButtonView.backgroundColor = AppColor.green.uiColor
        reviewButtonView.setTitle("Review", for: .normal)

        //package icon view
        packageIconView.layer.cornerRadius = 16
        packageIconView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        packageIconView.backgroundColor = UIColor.orange
        packageIconView.contentMode = .scaleAspectFit

        //community view
        communityView.configure(with: 169457, #imageLiteral(resourceName: "user"))

        //lessons view
        lessonsView.configure(with: 45, #imageLiteral(resourceName: "pay"))
    }

    func buildLayouts() -> Void {

        addSubviews(with: [packageIconView, packageNameLabelView, communityView, lessonsView, reviewButtonView])
        reviewButtonView.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.bottom).offset(-verticalPadding)
            make.height.equalTo(31)
            make.left.equalTo(snp.centerX).offset(30)
            make.right.equalTo(snp.right).offset(-30)
        }

        packageIconView.snp.makeConstraints { (make) in
            make.top.equalTo(verticalPadding)
            make.bottom.equalTo(-verticalPadding)
            make.left.equalTo(horizontalPadding)
            make.height.equalTo(141)
            make.width.equalTo(128)
        }

        packageNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(verticalPadding + 14)
            make.left.equalTo(packageIconView.snp.right).offset(18)
            make.right.equalTo(-horizontalPadding - 18)
        }

        communityView.snp.makeConstraints { (make) in
            make.top.equalTo(packageNameLabelView.snp.bottom).offset(20)
            make.left.equalTo(packageNameLabelView.snp.left)
        }

        lessonsView.snp.makeConstraints { (make) in
            make.top.equalTo(communityView.snp.bottom).offset(6)
            make.left.equalTo(packageNameLabelView.snp.left)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }

    func buildTargets() -> Void {

        reviewButtonView.addTarget(self, action: #selector(reviewPressed), for: .touchUpInside)
    }

}
