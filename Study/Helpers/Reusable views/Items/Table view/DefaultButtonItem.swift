//
//  DefaultButtonItem.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class DefaultButtonItem: UITableViewCell {

    var buttonPressed: (()->())? = nil

    private lazy var buttonView: UIButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: DefaultButtonItem")
    }

    func configure(with title: String?) -> Void {
        self.buttonView.setTitle(title, for: .normal)
    }
}

// MARK: - Actions

private extension DefaultButtonItem {

    @objc
    func didPressed() -> Void {
        buttonPressed?()
    }
}

// MARK: - Builds

private extension DefaultButtonItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none
        backgroundColor = AppColor.white.uiColor

        //button view
        buttonView.setTitleColor(AppColor.main.uiColor, for: .normal)
    }

    func buildLayouts() -> Void {

        addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.top.equalTo(5.byWidth())
            make.bottom.equalTo(-5.byWidth())
            make.left.equalTo(16.byWidth())
            make.right.equalTo(-16.byWidth())
        }
    }

    func buildTargets() -> Void {

        buttonView.addTarget(self, action: #selector(didPressed), for: .touchUpInside)
    }
}

