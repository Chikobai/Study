//
//  ProfileNotificationItem.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class ProfileNotificationItem: UITableViewCell {

    var switchValueChanged: ((Bool)->())?

    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var subtitleLabelView: UILabel = UILabel()
    private(set) lazy var switchView: UISwitch = UISwitch()

    private let verticalPaddingValue: CGFloat = 6

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
        print("DEINIT: ProfileNotificationItem")
    }
}

// MARK: - Targets

extension ProfileNotificationItem {

    @objc func switchChangedEvent(_ sender: UISwitch) -> Void {

        StoreManager.shared().setNotification(with: sender.isOn)
        switchValueChanged?(sender.isOn)
    }
}

// MARK: - Builds

private extension ProfileNotificationItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear
        contentView.backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //title label view
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.font = .boldSystemFont(ofSize: 14.byWidth())
        titleLabelView.text = AppTitle.Profile.notification

        //subtitle label view
        subtitleLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.95)
        subtitleLabelView.font = .systemFont(ofSize: 11.byWidth())
        subtitleLabelView.text = AppTitle.Profile.notificationSubtitle

        //switch view
        switchView.tintColor = AppColor.main.uiColor
        switchView.onTintColor = AppColor.main.uiColor
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, subtitleLabelView, switchView])
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(45.byWidth())
            make.top.equalTo(12.byWidth() + verticalPaddingValue)
        }

        subtitleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabelView)
            make.top.equalTo(titleLabelView.snp.bottom).offset(5.byWidth())
            make.bottom.equalTo(-12.byWidth() - verticalPaddingValue)
        }

        switchView.snp.makeConstraints { (make) in
            make.right.equalTo(-25.byWidth())
            make.centerY.equalToSuperview()
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: verticalPaddingValue, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }

    func buildTargets() -> Void {

        switchView.addTarget(self, action: #selector(switchChangedEvent), for: .valueChanged)
    }
}
