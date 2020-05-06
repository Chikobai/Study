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

    var changePhotoDidPressed: (()->())?

    private(set) lazy var photoImageView: UIImageView = UIImageView()
    private lazy var changeButtonView: UIButton = UIButton()

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

    @objc
    func changeButtonPressed() -> Void {

        changePhotoDidPressed?()
    }
}

// MARK: - Builds

private extension SettingsHeaderItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //photo image view
        photoImageView.backgroundColor = .lightGray
        photoImageView.layer.cornerRadius = 42.byWidth()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.alpha = 0.5

        //change button view
        changeButtonView.setBackgroundImage(#imageLiteral(resourceName: "technology"), for: .normal)
        changeButtonView.backgroundColor = .clear
    }

    func buildLayouts() -> Void {

        addSubviews(with: [photoImageView, changeButtonView])
        photoImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(15.byWidth())
            make.bottom.equalTo(-25.byWidth())
            make.width.height.equalTo(90.byWidth())
        }

        changeButtonView.snp.makeConstraints { (make) in
            make.center.equalTo(photoImageView)
            make.height.width.equalTo(30.byWidth())
        }
    }

    func buildTargets() -> Void {

        changeButtonView.addTarget(self, action: #selector(changeButtonPressed), for: .touchUpInside)
    }
}

