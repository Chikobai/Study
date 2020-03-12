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
            return self.headerItem(with: tableView, indexPath)
        case .languagePickerItem:
            return self.languageItem(with: tableView, indexPath, item)
        case .changablePhoneItem, .changableNameItem:
            return self.changableItemView(with: tableView, indexPath, item)
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
        if items[indexPath.section].cells[indexPath.row] == .exitItem {
            cell.textLabel?.textColor = .red
        }
        return cell
    }

    func changableItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
    ) -> SettingsChangableItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsChangableItem.cellIdentifier(), for: indexPath) as? SettingsChangableItem
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = item.subtitle

        return cell!
    }

    func headerItem(
        with tableView: UITableView,
        _ indexPath: IndexPath
    ) -> SettingsHeaderItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsHeaderItem.cellIdentifier(), for: indexPath) as? SettingsHeaderItem
        return cell!
    }

    func languageItem(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ item: SettingsItem
    ) -> SettingsLanguageItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsLanguageItem.cellIdentifier(), for: indexPath) as? SettingsLanguageItem
        cell?.textLabel?.text = item.title
        cell?.textInputView.text = "Казакша"
        
        return cell!
    }
}
