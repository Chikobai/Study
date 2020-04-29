//
//  FilledButton.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class FilledButton: LoadingButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: FilledButton")
    }

    func configure(with title: String?) -> Void {

        setTitle(title, for: .normal)
    }
}

// MARK: - Builds

private extension FilledButton {

    func build() -> Void {

        buildViews()
    }

    func buildViews() -> Void {

        setTitleColor(AppColor.white.uiColor, for: .normal)
        backgroundColor = AppColor.main.uiColor
        layer.cornerRadius = 8.byWidth()
    }
}

