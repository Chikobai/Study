//
//  AuthorizationValidator.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

protocol AuthorizationValidatorStrategy {

    func isValid(
        with params: [String : String],
        complitionOfSuccess: @escaping (([String: String])->()),
        complitionOfError: @escaping ((String)->())
        ) -> Void
}

final class LoginStrategy:  AuthorizationValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String: String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

        if let email = params[AppKey.Authorization.email],
            email.isValidEmail() == true {

            if let password = params[AppKey.Authorization.password], password.count > 7 {
                complitionOfSuccess(params)
            }
            else{
                complitionOfError(AppErrorMessage.Authorization.passwordIsSoWeak)
            }
        }
        else{
            complitionOfError(AppErrorMessage.Authorization.emailIsNotValid)
        }
    }
}


final class RegistrationStrategy:  AuthorizationValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

        if let name = params[AppKey.Authorization.name],
            name.removingWhitespaces().isEmpty == false {

            if let surname = params[AppKey.Authorization.surname], surname.removingWhitespaces().isEmpty == false {

                if let email = params[AppKey.Authorization.email],
                    email.isValidEmail() == true {

                    if let password = params[AppKey.Authorization.password], password.count > 7 {
                        complitionOfSuccess(params)
                    }
                    else{
                        complitionOfError(AppErrorMessage.Authorization.passwordIsSoWeak)
                    }
                }
                else{
                    complitionOfError(AppErrorMessage.Authorization.emailIsNotValid)
                }
            }
            else{
                complitionOfError(AppErrorMessage.Authorization.surnameIsEmpty)
            }
        }
        else{
            complitionOfError(AppErrorMessage.Authorization.nameIsEmpty)
        }
    }
}


final class OTPStrategy:  AuthorizationValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {


    }
}

final class ContextAuthorizationValidator {

    private var params: [String:String] = [:]
    private var typedText: [String:String] = [:]
    private var context: AuthorizationValidatorStrategy?

    init(with type: AuthorizationSection) {
        switch type {
        case .login, .loginWithEmail:
            self.context = LoginStrategy()
        case .registration, .registrationWithEmail:
            self.context = RegistrationStrategy()
        default:
            self.context = OTPStrategy()
        }
    }

    func setParameter(key: String, value: String?, id: Int?) -> Void {
        params[key] = (id == nil) ? value : "\(id!)"
        typedText[key] = value
        print(params)
    }

    func executeValidation(
        complitionOfSuccess: @escaping (([String: String])->()),
        complitionOfError: @escaping ((String)->())
        ) -> Void {

        context?.isValid(with: params, complitionOfSuccess: { validParams in
            complitionOfSuccess(validParams)
        }, complitionOfError: { (message) in
            complitionOfError(message)
        })
    }
}
