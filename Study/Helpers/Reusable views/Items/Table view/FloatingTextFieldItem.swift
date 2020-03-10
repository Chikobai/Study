//
//  FloatingTextFieldItem.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit



class FloatingTextFieldItem: UITableViewCell {

    var didTyped: ((String?)->())?

    private lazy var textField: FloatingTextField = FloatingTextField()
    private lazy var visibilityButtonView: UIButton = UIButton()
    private let visibilityCoverView: UIView = UIView(frame: CGRect(x: 0, y: 0,width: 35,height: 25))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: FloatingTextFieldItem")
    }

    func configure(with type: AuthorizationItem) -> Void {
        textField.isSecureTextEntry = type.isSecureTextEntry
        textField.placeholder = type.placeholder
        textField.keyboardType = type.keyboardType

        visibilityButtonView.isHidden = !type.isSecureTextEntry
        textField.rightView = (type.isSecureTextEntry == true) ? visibilityCoverView : nil
        textField.rightViewMode = (type.isSecureTextEntry == true) ? .always : .never

        if let maskString = type.maskString {
            textField.maskString = maskString
        }
    }

    func configure(with type: RestorePasswordItem) -> Void {
        textField.isSecureTextEntry = type.isSecureTextEntry
        textField.placeholder = type.placeholder
        textField.keyboardType = type.keyboardType

        visibilityButtonView.isHidden = !type.isSecureTextEntry
        textField.rightView = (type.isSecureTextEntry == true) ? visibilityCoverView : nil
        textField.rightViewMode = (type.isSecureTextEntry == true) ? .always : .never

        if let maskString = type.maskString {
            textField.maskString = maskString
        }
    }
}

private extension FloatingTextFieldItem {

    @objc
    func visibilityControl(_ sender: UIButton) {
        if textField.isSecureTextEntry == true {
            visibilityButtonView.setImage(#imageLiteral(resourceName: "invisible"), for: .normal)
        }
        else{
            visibilityButtonView.setImage(#imageLiteral(resourceName: "visibility"), for: .normal)
        }
        textField.isSecureTextEntry.toggle()
    }
}

// MARK: - Builds

private extension FloatingTextFieldItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none
        backgroundColor = AppColor.white.uiColor

        //visibility button view
        visibilityButtonView.setImage(#imageLiteral(resourceName: "visibility"), for: .normal)

    }

    func buildLayouts() -> Void {

        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(10.0)
            make.bottom.equalTo(-10.0)
            make.left.equalTo(16.0)
            make.right.equalTo(-16.0)
            make.height.equalTo(56.0)
        }

        addSubview(visibilityButtonView)
        visibilityButtonView.snp.makeConstraints { (make) in
            make.width.height.equalTo(25.0)
            make.centerY.equalToSuperview()
            make.right.equalTo(-25.0)
        }
    }

    func buildServices() -> Void {

        textField.didTyped = { [weak self] text in
            self?.didTyped?(text)
        }
    }

    func buildTargets() -> Void {

        visibilityButtonView.addTarget(self, action: #selector(visibilityControl), for: .touchUpInside)
    }
}
