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
    case emailInput
    case otpInput
    case repeatePasswordInput
    case sendOTPButton
    case restorePasswordButton
    case changePasswordButton
    case toOTPButton
    case OTPMessage
    case enterPhoneMessage
    case enterEmailMessage
    case restorePasswordMessage
    case changePasswordMessage
    case emptySpacer

    var placeholder: String?{
        switch self {
        case .phoneInput:
            return AppTitle.RestorePassword.enterPhoneNumber
        case .passwordInput:
            return AppTitle.RestorePassword.enterPassword
        case .repeatePasswordInput:
            return AppTitle.RestorePassword.repeateEnterPassword
        case .sendOTPButton:
            return AppTitle.RestorePassword.resume
        case .restorePasswordButton:
            return AppTitle.RestorePassword.restore
        case .toOTPButton:
            return AppTitle.RestorePassword.resume
        case .restorePasswordMessage:
            return AppTitle.RestorePassword.restorePasswordMessage
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
        case .passwordInput, .repeatePasswordInput:
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
        case .passwordInput, .repeatePasswordInput:
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
        return "KEY"
    }
}

enum RestorePasswordSection {

    case enterPhone
    case enterEmail
    case otp
    case restorePassword
    case changePassword

    var title: String?{
        switch self {
        case .otp:
            return AppTitle.RestorePassword.OTP
        case .changePassword:
            return AppTitle.RestorePassword.changePassword
        default:
            return AppTitle.RestorePassword.restorePassword
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
            return [.restorePasswordMessage, .passwordInput, .repeatePasswordInput, .restorePasswordButton]
        case .changePassword:
            return [.changePasswordMessage, .passwordInput, .repeatePasswordInput, .changePasswordButton]
        }
    }
}
