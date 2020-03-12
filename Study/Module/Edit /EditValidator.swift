//
//  EditValidator.swift
//  Study
//
//  Created by I on 3/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

protocol EditValidatorStrategy {

    func isValid(
        with params: [String : String],
        complitionOfSuccess: @escaping (([String: String])->()),
        complitionOfError: @escaping ((String)->())
        ) -> Void
}

final class PhoneChangeStrategy:  EditValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String: String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

    }
}


final class UserNameChangeStrategy:  EditValidatorStrategy{

    func isValid(with params: [String : String], complitionOfSuccess: @escaping (([String : String]) -> ()), complitionOfError: @escaping ((String) -> ())) {

    }
}


final class ContextEditValidator {

    private var params: [String:String] = [:]
    private var typedText: [String:String] = [:]
    private var context: EditValidatorStrategy?

    init(with type: EditSection) {
        
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
