//
//  SettingsAdapter.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class SettingsAdapter: NSObject {

    private var profile: Profile? {
        get{
            return StoreManager.shared().profile()
        }
    }
    private var items: [SettingsSectionItem] = [.header, .changableProfile, .additional]
    weak var delegate: SettingsDelegate?

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: SettingsAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SettingsAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cells.count
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if items[indexPath.section].cells[indexPath.row] == .headerItem {
            return UITableView.automaticDimension
        }
        return 56.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items[indexPath.section].cells[indexPath.row]
        switch item {
        case .headerItem:
            return self.headerItem(with: tableView, indexPath, item)
        case .changableEmailItem, .changableNameItem:
            return self.changableItemView(with: tableView, indexPath, item)
        case .languagePickerItem:
            return self.languageItem(with: tableView, indexPath, item)
        default:
            return self.defaultItemView(with: tableView, indexPath, item)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section].cells[indexPath.row]
        delegate?.didSelected(with: item)
    }
}


// MARK: - Custom Items

private extension SettingsAdapter {

    func defaultItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier(), for: indexPath)
        cell.textLabel?.text = item.title
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.selectionStyle = .none

        if item == .exitItem {
            cell.textLabel?.textColor = .red
        }
        else if item == .changablePasswordItem {
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

    func changableItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
    ) -> SettingsChangableItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsChangableItem.cellIdentifier(), for: indexPath) as? SettingsChangableItem

        if let profile = profile {
            cell?.textLabel?.text = (item == .changableEmailItem) ?
                profile.email : profile.first_name + " " + profile.last_name
        }
        cell?.detailTextLabel?.text = item.subtitle

        return cell!
    }

    func headerItem(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
    ) -> SettingsHeaderItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsHeaderItem.cellIdentifier(), for: indexPath) as? SettingsHeaderItem
        cell?.photoImageView.kf.indicatorType = .activity
        if let profile = profile {
            cell?.photoImageView.kf.setImage(with: URL.init(string: profile.image))
        }

        cell?.changePhotoDidPressed = { [weak self] in
            self?.delegate?.didSelected(with: item)
        }

        return cell!
    }


    func languageItem(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
        ) -> SettingsLanguageItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsLanguageItem.cellIdentifier(), for: indexPath) as? SettingsLanguageItem
        cell?.textLabel?.text = item.title

        cell?.languageChanged = { [weak self] in
            self?.delegate?.languageChanged(with: AppErrorMessage.Language.success)
        }
        
        return cell!
    }
}
