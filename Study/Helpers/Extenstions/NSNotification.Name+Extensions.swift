//
//  Notification+Ext.swift
//  Jiber
//
//  Created by I on 9/27/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation


extension NSNotification.Name {
    enum Notifications: String {
        case startLoading
        case stopLoading
    }
    init(_ value: Notifications) {
        self = NSNotification.Name(value.rawValue)
    }
}
