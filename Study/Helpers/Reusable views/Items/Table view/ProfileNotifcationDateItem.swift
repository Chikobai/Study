//
//  ProfileNotifcationDatePickerItem.swift
//  Study
//
//  Created by I on 5/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class ProfileNotifcationDateItem: UITableViewCell {

    var valueChanged: (()->())?
    private let verticalPaddingValue: CGFloat = 6.0
    
    private(set) lazy var titleLabelView: UILabel = UILabel()
    private(set) lazy var textInputView: UITextField = UITextField()
    private(set) lazy var pickerView: DatePickerViewManager = DatePickerViewManager()

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
        print("DEINIT: ProfileNotifcationDateItem")
    }
}

private extension ProfileNotifcationDateItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        //superview
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = AppColor.white.uiColor

        //title label view
        titleLabelView.font = .boldSystemFont(ofSize: 14.byWidth())

        //text input view
        textInputView.font = .systemFont(ofSize: 15.byWidth())
        textInputView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        textInputView.inputView = pickerView
        textInputView.textAlignment = .right
        textInputView.tintColor = .clear

        //picker view
        pickerView.valueChanged = { [weak self] value in
            self?.textInputView.text = value
            StoreManager.shared().setNotificationTime(with: value)
            self?.valueChanged?()
        }
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, textInputView])

        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(45.byWidth())
            make.centerY.equalToSuperview()
        }

        textInputView.snp.makeConstraints { (make) in
            make.right.equalTo(-25.byWidth())
            make.width.equalTo(100.byWidth())
            make.height.equalTo(44.byWidth())
            make.top.equalTo(verticalPaddingValue)
            make.bottom.equalTo(-verticalPaddingValue)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: verticalPaddingValue, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }
}
