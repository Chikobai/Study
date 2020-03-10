//
//  SettingsHeaderView.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class SettingsHeaderItem: UITableViewCell {

    private lazy var photoImageView: UIImageView = UIImageView()
    private lazy var nameLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: SettingsHeaderView")
    }
}

// MARK: - Builds

private extension SettingsHeaderItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //photo image view
        photoImageView.backgroundColor = .lightGray
        photoImageView.layer.cornerRadius = 42.5
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.image = #imageLiteral(resourceName: "8aa0748250185d0dba6c4ec4b217680e")

        //name label view
        nameLabelView.text = "Aibek S."
        nameLabelView.font = .systemFont(ofSize: 20)
        nameLabelView.textColor = AppColor.main.uiColor
    }

    func buildLayouts() -> Void {

        addSubviews(with: [photoImageView, nameLabelView])
        photoImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15.0)
            make.bottom.equalTo(-15.0)
            make.width.height.equalTo(85.0)
        }

        nameLabelView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(photoImageView.snp.right).offset(30)
            make.right.equalTo(-30)
        }
    }
}

