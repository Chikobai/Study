//
//  SettingsLanguageItem.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class SettingsLanguageItem: UITableViewCell {

    var languageChanged: (()->())?

    private(set) lazy var titleLabelView: UILabel = UILabel()
    private(set) lazy var textInputView: UITextField = UITextField()
    private(set) lazy var pickerView: PickerViewManager = PickerViewManager()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: SettingsLanguageItem")
    }
}

private extension SettingsLanguageItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //title label view
        titleLabelView.font = .systemFont(ofSize: 15)

        //text input view
        textInputView.font = .systemFont(ofSize: 15)
        textInputView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        textInputView.inputView = pickerView
        textInputView.textAlignment = .right
        textInputView.tintColor = .clear

        //picker view
        pickerView.pickableItems = [
            Language(key: AppKey.Language.kazakh, title: AppTitle.Language.kazakh.localized),
            Language(key: AppKey.Language.russian, title: AppTitle.Language.russian.localized)
        ]
        pickerView.didSelect = { [weak self] language in
            StoreManager.shared().setLanguage(with: language)
            self?.textInputView.text = language.title
            self?.languageChanged?()
        }
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, textInputView])
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(15.0)
            make.centerY.equalToSuperview()
        }

        textInputView.snp.makeConstraints { (make) in
            make.right.equalTo(-15.0)
            make.left.equalTo(titleLabelView.snp.right).offset(10.0)
            make.height.equalTo(50.0)
            make.centerY.equalToSuperview()
        }
    }
}
