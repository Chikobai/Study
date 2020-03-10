//
//  OTPTextField.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class OTPTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: OTPTextField")
    }
}

// MARK: - Builds

private extension OTPTextField {

    func build() -> Void {

        buildViews()
    }

    func buildViews() -> Void {

        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        textAlignment = .center
        font = .systemFont(ofSize: 18)
    }
}
