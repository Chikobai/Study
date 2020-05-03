//
//  ProfileModels.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum ProfileItem {

    case statisticItem
    case notificationTimeItem
    case notificationSwitchItem
    case certificatesItem
}

enum ProfileSectionItem {

    case statistic
    case notification
    case certificates

    var cells: [ProfileItem] {
        switch self {
        case .statistic:
            return [.statisticItem]
        case .notification:
            return [.notificationSwitchItem, .notificationTimeItem]
        case .certificates:
            return [.certificatesItem]
        }
    }

}
