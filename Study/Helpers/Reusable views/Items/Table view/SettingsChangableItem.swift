//
//  SettingsChangableItem.swift
//  Study
//
//  Created by I on 3/5/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class SettingsChangableItem: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: SettingsChangableItem")
    }
}

private extension SettingsChangableItem {

    func build() -> Void {

        buildViews()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        selectionStyle = .none

        //text label view
        textLabel?.font = .systemFont(ofSize: 15)

        //detail label view
        detailTextLabel?.font = .systemFont(ofSize: 12)
        detailTextLabel?.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
    }
}
