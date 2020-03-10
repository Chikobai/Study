//
//  CourseInfoAdabter.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class CourseInfoAdapter: NSObject {

    weak var scrollDelegate: CourseInfoScrollDelegate?
    private var descriptionIsExpanded: Bool = false

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseInfoAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseInfoAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            return descriptionItemView(with: tableView, indexPath)
        }
        else if indexPath.row == 1 {
            return languageItemView(with: tableView, indexPath)
        }
        else if indexPath.row == 2 {
            return skillsItemView(with: tableView, indexPath)
        }
        return teacherItemView(with: tableView, indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

// MARK: - UIScrollViewDelegate

extension CourseInfoAdapter: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView: scrollView, tableView: nil)
    }
}


// MARK: - Custom Items

private extension CourseInfoAdapter {

    func descriptionItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoDescriptionItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoDescriptionItem.cellIdentifier(), for: indexPath) as? CourseInfoDescriptionItem
        cell?.configure(with: "Birdene turady myna jerde", "Sphingolipids are a class of lipids containing a backbone of sphingoid bases, a set of aliphatic amino alcohols that includes sphingosine. They were discovered in brain extracts in the 1870s and were named after the mythological sphinx because of their enigmatic nature.Sphingolipids are a class of lipids containing a backbone of sphingoid bases, a set of aliphatic amino alcohols that includes sphingosine. They were discovered in brain extracts in the 1870s and were named after the mythological sphinx because of their enigmatic nature", descriptionIsExpanded)
        cell?.superviewGestureNotified = { [weak self] in
            self?.descriptionIsExpanded.toggle()
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }

        return cell!

    }

    func teacherItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoTeacherItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoTeacherItem.cellIdentifier(), for: indexPath) as? CourseInfoTeacherItem

        return cell!
    }

    func skillsItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoSkillsItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoSkillsItem.cellIdentifier(), for: indexPath) as? CourseInfoSkillsItem
        cell?.configure(with: ["Discrete Math", "Math", "Statistic", "Marketolog", "Geo"])
        return cell!
    }

    func languageItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoLanguageItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoLanguageItem.cellIdentifier(), for: indexPath) as? CourseInfoLanguageItem

        return cell!
    }
}
