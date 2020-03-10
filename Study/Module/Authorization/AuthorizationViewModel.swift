//
//  AuthorizationViewModel.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum AuthorizationItem {

    case phoneInput
    case passwordInput
    case emailInput
    case otpInput
    case nameInput
    case loginButton
    case sendOTPButton
    case resgistrationButton
    case toRestorePasswordButton
    case toResgistrationButton
    case toLoginButton
    case OTPMessage
    case loginMessage
    case loginWithEmailMessage
    case emptySpacer

    var placeholder: String?{
        switch self {
        case .phoneInput:
            return AppTitle.Authorization.enterPhoneNumber
        case .passwordInput:
            return AppTitle.Authorization.enterPassword
        case .nameInput:
            return AppTitle.Authorization.enterName
        case .loginButton:
            return AppTitle.Authorization.enter
        case .resgistrationButton:
            return AppTitle.Authorization.registration
        case .toResgistrationButton:
            return AppTitle.Authorization.registration
        case .toRestorePasswordButton:
            return AppTitle.Authorization.restorePassword
        case .toLoginButton:
            return AppTitle.Authorization.iHaveAnAccount
        case .OTPMessage:
            return AppTitle.Authorization.OTPMessage
        case .loginMessage:
            return AppTitle.Authorization.loginMessage
        case .sendOTPButton:
            return AppTitle.Authorization.resume
        case .emailInput:
            return AppTitle.Authorization.enterEmail
        case .loginWithEmailMessage:
            return AppTitle.Authorization.loginWithEmailMessage
        default:
            return nil
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .passwordInput:
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
        case .passwordInput:
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

enum AuthorizationSection {

    case login
    case loginWithEmail
    case registration
    case registrationWithEmail
    case otp

    var title: String?{
        switch self {
        case .login, .loginWithEmail:
            return AppTitle.Authorization.login
        case .registration, .registrationWithEmail:
            return AppTitle.Authorization.registration
        case .otp:
            return AppTitle.Authorization.OTP
        }
    }

    var cells: [AuthorizationItem] {
        switch self {
        case .login:
            return [.loginMessage, .phoneInput, .passwordInput, .loginButton, .emptySpacer, .toRestorePasswordButton, .toResgistrationButton]
        case .loginWithEmail:
            return [.loginWithEmailMessage, .emailInput, .passwordInput, .loginButton, .emptySpacer, .toRestorePasswordButton, .toResgistrationButton]
        case .registration, .registrationWithEmail:
            return [.nameInput, .emailInput, .passwordInput, .resgistrationButton, .emptySpacer, .toLoginButton]
        case .otp:
            return [.emptySpacer, .OTPMessage, .emptySpacer, .otpInput , .sendOTPButton]
        }
    }
}
