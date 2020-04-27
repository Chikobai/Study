//
//  RestorePasswordViewModel.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum RestorePasswordItem {

    case phoneInput
    case passwordInput
    case oldPasswordInput
    case emailInput
    case otpInput
    case repeatePasswordInput
    case sendOTPButton
    case restorePasswordButton
    case restoreEmailButton
    case changePasswordButton
    case toOTPButton
    case OTPMessage
    case enterPhoneMessage
    case enterEmailMessage
    case restorePasswordMessage
    case restoreEmailMessage
    case changePasswordMessage
    case emptySpacer

    var placeholder: String?{
        switch self {
        case .phoneInput:
            return AppTitle.RestorePassword.enterPhoneNumber
        case .passwordInput:
            return AppTitle.RestorePassword.enterPassword
        case .oldPasswordInput:
            return AppTitle.RestorePassword.enterOldPassword
        case .repeatePasswordInput:
            return AppTitle.RestorePassword.repeateEnterPassword
        case .sendOTPButton:
            return AppTitle.RestorePassword.resume
        case .restorePasswordButton:
            return AppTitle.RestorePassword.resume
        case .restoreEmailButton:
            return AppTitle.RestorePassword.resume
        case .toOTPButton:
            return AppTitle.RestorePassword.resume
        case .restorePasswordMessage:
            return AppTitle.RestorePassword.restorePasswordMessage
        case .restoreEmailMessage:
            return AppTitle.RestorePassword.restoreEmailMessage
        case .OTPMessage:
            return AppTitle.RestorePassword.OTPMessage
        case .enterPhoneMessage:
            return AppTitle.RestorePassword.enterPhoneMessage
        case .changePasswordMessage:
            return AppTitle.RestorePassword.changePasswordMessage
        case .changePasswordButton:
            return AppTitle.RestorePassword.change
        case .enterEmailMessage:
            return AppTitle.RestorePassword.enterEmailMessage
        case .emailInput:
            return AppTitle.RestorePassword.enterEmail
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
        default:
            return "KEY"
        }
    }
}

enum RestorePasswordSection {

    case enterPhone
    case enterEmail
    case otp
    case restorePassword
    case restoreEmail
    case changePassword

    var title: String?{
        switch self {
        case .otp:
            return AppTitle.RestorePassword.OTP
        case .changePassword:
            return AppTitle.RestorePassword.changePassword
        case .restorePassword:
            return AppTitle.RestorePassword.restorePassword
        case .restoreEmail:
            return AppTitle.RestorePassword.restoreEmail
        default:
            return nil
        }
    }

    var cells: [RestorePasswordItem] {
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
        }
    }
}
