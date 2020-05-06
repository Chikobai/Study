//
//  RestoreViewModel.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum RestoreItem {

    case phoneInput
    case nameInput
    case lastnameInput
    case passwordInput
    case oldPasswordInput
    case emailInput
    case otpInput
    case repeatePasswordInput
    case sendOTPButton
    case restorePasswordButton
    case restoreEmailButton
    case changePasswordButton
    case changeFullnameButton
    case toOTPButton
    case OTPMessage
    case enterPhoneMessage
    case enterEmailMessage
    case restorePasswordMessage
    case restoreEmailMessage
    case changePasswordMessage
    case changeFullnameMessage
    case emptySpacer

    var placeholder: String?{
        switch self {
        case .phoneInput:
            return AppTitle.Restore.enterPhoneNumber
        case .passwordInput:
            return AppTitle.Restore.enterPassword
        case .oldPasswordInput:
            return AppTitle.Restore.enterOldPassword
        case .repeatePasswordInput:
            return AppTitle.Restore.repeateEnterPassword
        case .sendOTPButton:
            return AppTitle.Restore.resume
        case .restorePasswordButton:
            return AppTitle.Restore.resume
        case .restoreEmailButton:
            return AppTitle.Restore.resume
        case .toOTPButton:
            return AppTitle.Restore.resume
        case .restorePasswordMessage:
            return AppTitle.Restore.restorePasswordMessage
        case .restoreEmailMessage:
            return AppTitle.Restore.restoreEmailMessage
        case .OTPMessage:
            return AppTitle.Restore.OTPMessage
        case .enterPhoneMessage:
            return AppTitle.Restore.enterPhoneMessage
        case .changePasswordMessage:
            return AppTitle.Restore.changePasswordMessage
        case .changePasswordButton:
            return AppTitle.Restore.change
        case .enterEmailMessage:
            return AppTitle.Restore.enterEmailMessage
        case .emailInput:
            return AppTitle.Restore.enterEmail
        case .changeFullnameButton:
            return AppTitle.Restore.change
        case .nameInput:
            return AppTitle.Restore.enterName
        case .lastnameInput:
            return AppTitle.Restore.enterLastname
        case .changeFullnameMessage:
            return AppTitle.Restore.changefullnameMessage
        default:
            return nil
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .passwordInput, .repeatePasswordInput, .oldPasswordInput:
            return .asciiCapable
        case .phoneInput:
            return .numberPad
        case .emailInput:
            return .emailAddress
        default:
            return .default
        }
    }

    var isSecureTextEntry: Bool {
        switch self {
        case .passwordInput, .repeatePasswordInput, .oldPasswordInput:
            return true
        default:
            return false
        }
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
        switch self {
        case .oldPasswordInput:
            return AppKey.Restore.oldPassword
        case .passwordInput:
            return AppKey.Restore.password
        case .repeatePasswordInput:
            return AppKey.Restore.repeatePassword
        case .emailInput:
            return AppKey.Restore.email
        case .nameInput:
            return AppKey.Restore.firstname
        case .lastnameInput:
            return AppKey.Restore.lastname
        default:
            return "KEY"
        }
    }
}

enum RestoreSection {

    case enterPhone
    case enterEmail
    case otp
    case restorePassword
    case restoreEmail
    case changePassword
    case changeUsername

    var title: String?{
        switch self {
        case .otp:
            return AppTitle.Restore.OTP
        case .changePassword:
            return AppTitle.Restore.changePassword
        case .restorePassword:
            return AppTitle.Restore.restorePassword
        case .restoreEmail:
            return AppTitle.Restore.restoreEmail
        case .changeUsername:
            return AppTitle.Restore.nameEdit
        default:
            return nil
        }
    }

    var cells: [RestoreItem] {
        switch self {
        case .enterPhone:
            return [.enterPhoneMessage, .phoneInput, .toOTPButton]
        case .enterEmail:
            return [.enterEmailMessage, .emailInput, .toOTPButton]
        case .otp:
            return [.emptySpacer, .OTPMessage, .emptySpacer, .otpInput , .sendOTPButton]
        case .restorePassword:
            return [.restorePasswordMessage, .emailInput, .restorePasswordButton]
        case .restoreEmail:
            return [.restoreEmailMessage, .emailInput, .restoreEmailButton]
        case .changePassword:
            return [.changePasswordMessage, .oldPasswordInput, .passwordInput, .repeatePasswordInput, .changePasswordButton]
        case .changeUsername:
            return [.changeFullnameMessage, .nameInput, .lastnameInput, .changeFullnameButton]
        }
    }
}
