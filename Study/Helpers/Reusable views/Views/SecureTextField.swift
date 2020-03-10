//
//  SecureTextField.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class SecureTextField: UITextField {

    deinit {
        print("DEINIT: SecureTextField")
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {

        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        } else if action == #selector(UIResponderStandardEditActions.cut(_:)) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
}
