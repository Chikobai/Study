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

    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var subtitleLabelView: UILabel = UILabel()
    private lazy var switchView: UISwitch = UISwitch()
    private lazy var separatorLineView: UIView = UIView()
    private lazy var fromTimeInputView: UITextField = UITextField()
    private lazy var toTimeInputView: UITextField = UITextField()

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
        print("DEINIT: ProfileNotificationItem")
    }
}

// MARK: - Builds

private extension ProfileNotificationItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.lightGray.uiColor
        contentView.backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //title label view
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.font = .boldSystemFont(ofSize: 14)
        titleLabelView.text = AppTitle.Profile.notification

        //subtitle label view
        subtitleLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.95)
        subtitleLabelView.font = .systemFont(ofSize: 11)
        subtitleLabelView.text = AppTitle.Profile.notificationSubtitle

        //separator line view
        separatorLineView.backgroundColor = AppColor.main.uiColor

        //from time input view
        fromTimeInputView.placeholder = "20:00"
        fromTimeInputView.textAlignment = .center
        fromTimeInputView.font = .boldSystemFont(ofSize: 22)
        fromTimeInputView.inputView = DatePickerViewManager()

        //to time input view
        toTimeInputView.placeholder = "23:00"
        toTimeInputView.textAlignment = .center
        toTimeInputView.font = .boldSystemFont(ofSize: 22)
        toTimeInputView.inputView = DatePickerViewManager()

        //switch view
        switchView.tintColor = AppColor.main.uiColor
        switchView.onTintColor = AppColor.main.uiColor
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, subtitleLabelView, switchView, fromTimeInputView, toTimeInputView, separatorLineView])
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(45)
            make.top.equalTo(12 + verticalPaddingValue)
        }

        subtitleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabelView)
            make.top.equalTo(titleLabelView.snp.bottom).offset(5)
        }

        switchView.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.top.equalTo(25)
        }

        fromTimeInputView.snp.makeConstraints { (make) in
            make.top.equalTo(switchView.snp.bottom).offset(20)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }

        separatorLineView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(1)
            make.top.equalTo(fromTimeInputView.snp.bottom).offset(5)
        }

        toTimeInputView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(5)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-20)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: 0, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }
}
