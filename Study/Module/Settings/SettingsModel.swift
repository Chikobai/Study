//
//  SettingsModel.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

enum SettingsItem {
    case headerItem
    case changableNameItem
    case changablePhoneItem
    case changableEmailItem
    case changablePasswordItem
    case languagePickerItem
    case aboutApplicationItem
    case helpItem
    case exitItem

    var title: String? {
        switch self {
        case .languagePickerItem:
            return AppTitle.Settings.language
        case .exitItem:
            return AppTitle.Settings.exit
        case .helpItem:
            return AppTitle.Settings.help
        case .aboutApplicationItem:
            return AppTitle.Settings.aboutApplication
        case .changablePasswordItem:
            return AppTitle.Settings.changePassword
        default:
            return nil
        }
    }

    var subtitle: String? {
        switch self {
        case .changableNameItem:
            return AppTitle.Settings.changeNameSubtitle
        case .changableEmailItem:
            return AppTitle.Settings.changeEmailSubtitle
        case .changablePhoneItem:
            return AppTitle.Settings.changePhoneSubtitle
        default:
            return nil
        }
    }
}

enum SettingsSectionItem {
    case header
    case changableProfile
    case additional

    var cells: [SettingsItem] {
        switch self {
        case .header:
            return [.headerItem]
        case .changableProfile:
            return [.changableNameItem, .changableEmailItem, .changablePasswordItem, .languagePickerItem]
        case .additional:
            return [.aboutApplicationItem, .helpItem, .exitItem]
        }
    }
}
