//
//  RestorePasswordValidator.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

protocol RestorePasswordValidatorStrategy {

    func isValid(
        with params: [String : String],
        complitionOfSuccess: @escaping (([String: String])->()),
        complitionOfError: @escaping ((String)->())
        ) -> Void
}

final class EnterPhoneStrategy:  RestorePasswordValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String: String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

    }
}


final class RestorePasswordOTPStrategy:  RestorePasswordValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

    }
}


final class RestorePasswordStrategy: RestorePasswordValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {


    }
}

final class ContextRestorePasswordValidator {

    private var params: [String:String] = [:]
    private var typedText: [String:String] = [:]
    private var context: RestorePasswordValidatorStrategy?

    init(with type: RestorePasswordSection) {
        switch type {
        case .enterPhone:
            self.context = EnterPhoneStrategy()
        case .otp:
            self.context = RestorePasswordOTPStrategy()
        default:
            self.context = RestorePasswordStrategy()
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
