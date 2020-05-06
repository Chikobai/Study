//
//  RestoreValidator.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

protocol RestoreValidatorStrategy {

    func isValid(
        with params: [String : String],
        complitionOfSuccess: @escaping (([String: String])->()),
        complitionOfError: @escaping ((String)->())
        ) -> Void
}


final class RestoreStrategy: RestoreValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

        if let email = params[AppKey.Restore.email],
            email.isValidEmail() == true {
            complitionOfSuccess(params)
        }
        else {
            complitionOfError(AppErrorMessage.Restore.emailIsNotValid)
        }
    }
}

final class ChangeFullnameStrategy: RestoreValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

        if let name = params[AppKey.Restore.firstname],
            name.removingWhitespaces().isEmpty == false {
            if let lastname = params[AppKey.Restore.lastname],
                lastname.removingWhitespaces().isEmpty == false {
                complitionOfSuccess(params)
            }
            else{
                complitionOfError(AppErrorMessage.Restore.surnameIsEmpty)
            }
        }
        else {
            complitionOfError(AppErrorMessage.Restore.nameIsEmpty)
        }
    }
}


final class ChangePasswordStrategy: RestoreValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

        if let oldPassword = params[AppKey.Restore.oldPassword], oldPassword.count > 7 {

            if let newPassword = params[AppKey.Restore.password], newPassword.count > 7 {

                if let repeatedPassword = params[AppKey.Restore.repeatePassword], newPassword == repeatedPassword {

                    complitionOfSuccess(params)
                }
                else {
                    complitionOfError(AppErrorMessage.Restore.passwordsAreNotEqual)
                }
            }
            else{
                complitionOfError(AppErrorMessage.Restore.passwordIsSoWeak)
            }
        }
        else {
            complitionOfError(AppErrorMessage.Restore.oldPasswordIsSoWeak)
        }
    }
}

final class ContextRestoreValidator {

    private var params: [String:String] = [:]
    private var typedText: [String:String] = [:]
    private var context: RestoreValidatorStrategy?

    init(with type: RestoreSection) {
        switch type {
        case .changePassword:
            self.context = ChangePasswordStrategy()
        case .changeUsername:
            self.context = ChangeFullnameStrategy()
        default:
            self.context = RestoreStrategy()
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
