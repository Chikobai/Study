//
//  AppKey.swift
//  Study
//
//  Created by I on 4/5/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

import Foundation

class AppKey {

    class Storage {

        static let diskConfigurationKey     = "DISKCONFIGURATIONKEY"
        static let token                    = "TOKEN"
        static let language                 = "LANGUAGE"
    }

    class Language {

        static let kazakh     = "kk-KZ"
        static let russian    = "ru"
    }

    class Authorization {

        static let email     = "email"
        static let password  = "password"
        static let name      = "first_name"
        static let surname   = "last_name"
    }

    class Restore {

        static let email           = "email"
        static let oldPassword     = "old_password"
        static let password        = "new_password"
        static let repeatePassword = "repeate_password"
    }
}
