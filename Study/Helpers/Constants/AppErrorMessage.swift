//
//  AppErrorMessage.swift
//  Study
//
//  Created by I on 4/5/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

class AppErrorMessage {

    static let somethingIsWrong = "something_is_wrong_message".localized
    static let success = "success_message".localized
    static let noData = "no_data_message".localized

    class Authorization {

        static let emailIsNotValid      = "email_is_not_valid_message".localized
        static let passwordIsSoWeak     = "password_is_so_weak_message".localized
        static let nameIsEmpty          = "name_is_empty_message".localized
        static let surnameIsEmpty       = "surname_is_empty_message".localized
        static let verification         = "verification_message".localized
    }
}
