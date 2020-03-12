//
//  EditModels.swift
//  Study
//
//  Created by I on 3/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum EditItem {

    case phoneInput
    case nameInput
    case changeButton
    case resumeButton
    case phoneMessageItem
    case nameMessageItem
    case emptySpacer

    var placeholder: String?{
        switch self {
        case .phoneInput:
            return AppTitle.Edit.enterPhoneNumber
        case .nameInput:
            return AppTitle.Edit.enterName
        case .phoneMessageItem:
            return AppTitle.Edit.changePhoneMessage
        case .nameMessageItem:
            return AppTitle.Edit.changeNameMessage
        case .changeButton:
            return AppTitle.Edit.change
        case .resumeButton:
            return AppTitle.Edit.resume
        default:
            return nil
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .phoneInput:
            return .numberPad
        default:
            return .default
        }
    }

    var isSecureTextEntry: Bool {
        return false
    }

    var maskString: String? {
        switch self {
        case .phoneInput:
            return "+{7} ([000]) [000] [00] [00]"
        default:
            return nil
        }
    }

    var key: String{
        return "KEY"
    }
}

enum EditSection {

    case changePhone
    case changeUserName

    var title: String?{
        switch self {
        case .changePhone:
            return AppTitle.Edit.phoneEdit
        case .changeUserName:
            return AppTitle.Edit.nameEdit
        }
    }

    var cells: [EditItem] {
        switch self {
        case .changeUserName:
            return [.nameMessageItem, .nameInput, .changeButton]
        case .changePhone:
            return [.nameMessageItem, .phoneInput, .resumeButton]
        }
    }
}
