//
//  ProfileAdapter.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class ProfileAdapter: NSObject {

    weak var delegate: ProfileDelegate?
    private var items: [ProfileSectionItem] = [.statistic, .notification, .certificates]

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: ProfileAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ProfileAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let source = items[indexPath.section].cells[indexPath.row]
        switch source {
        case .statisticItem:
            return self.statisticsItem(with: tableView, indexPath)
        case .certificatesItem:
            return self.certificatesItem(with: tableView, indexPath)
        case .notificationTimeItem:
            return self.notificationsItem(with: tableView, indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
}

extension ProfileAdapter {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        delegate?.didScroll(with: scrollView.contentOffset.y)
    }
}


// MARK: - Custom Items

private extension ProfileAdapter {

    func statisticsItem(with tableView: UITableView, _ indexPath: IndexPath) -> ProfileStatisticsItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileStatisticsItem.cellIdentifier(), for: indexPath) as? ProfileStatisticsItem
//        cell?.backgroundColor = .red
        return cell!
    }

    func notificationsItem(with tableView: UITableView, _ indexPath: IndexPath) -> ProfileNotificationItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileNotificationItem.cellIdentifier(), for: indexPath) as? ProfileNotificationItem
        //        cell?.backgroundColor = .red
        return cell!
    }

    func certificatesItem(with tableView: UITableView, _ indexPath: IndexPath) -> ProfileCertificateItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCertificateItem.cellIdentifier(), for: indexPath) as? ProfileCertificateItem
        //        cell?.backgroundColor = .red
        return cell!
    }
}
