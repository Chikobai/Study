//
//  FilledButtonItem.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class FilledButtonItem: UITableViewCell {

    var buttonPressed: (()->())? = nil

    private lazy var buttonView: FilledButton = FilledButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: FilledButtonItem")
    }

    func configure(with title: String?) -> Void {
        self.buttonView.configure(with: title)
    }
}

// MARK: - Actions

private extension FilledButtonItem {

    @objc
    func didPressed() -> Void {
        buttonPressed?()
    }
}

// MARK: - Builds

private extension FilledButtonItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none
        backgroundColor = AppColor.white.uiColor
    }

    func buildLayouts() -> Void {

        addSubview(buttonView)
        buttonView.snp.makeConstraints { (make) in
            make.top.equalTo(10.byWidth())
            make.bottom.equalTo(-10.byWidth())
            make.left.equalTo(16.byWidth())
            make.right.equalTo(-16.byWidth())
            make.height.equalTo(50.byWidth())
        }
    }

    func buildTargets() -> Void {

        buttonView.addTarget(self, action: #selector(didPressed), for: .touchUpInside)
    }
}
