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

    class AppDelegate {

        static let localNotification     = "LOCAL_NOTIFICATION"
    }

    class Storage {

        static let diskConfigurationKey     = "DISKCONFIGURATIONKEY"
        static let token                    = "TOKEN"
        static let notification             = "NOTIFICATION"
        static let notificationTime         = "NOTIFICATION_TIME"
        static let language                 = "LANGUAGE"
        static let profile                  = "PROFILE"
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
        static let lastname = "last_name"
        static let firstname = "first_name"
    }

    class CourseDetails {

        static let comment          = "text"
        static let rating           = "rating"
    }
}
