//
//  CourseInfoAdabter.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

enum CourseInfoItem {

    case descriptions
    case languages
    case skillsTitle
    case skills
    case teachers
}

class CourseInfoAdapter: NSObject {

    private var object: CourseInfo?
    private let items: [CourseInfoItem] = [.descriptions, .languages, .skillsTitle,.skills, .teachers]
    private var descriptionIsExpanded: Bool = false
    private var estimateRowHeightStorage: [IndexPath:CGFloat] = [:]

    override init() {
        super.init()
    }

    deinit {
        print("DEINIT: CourseInfoAdapter")
    }

    func setObject(with value: CourseInfo) -> Void {

        self.object = value
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CourseInfoAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let estimatedHeight = estimateRowHeightStorage[indexPath] {
            return estimatedHeight
        }
        return  UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch items[indexPath.section] {
        case .descriptions:
            return descriptionItemView(with: tableView, indexPath)
        case .languages:
            return languageItemView(with: tableView, indexPath)
        case .skills:
            return skillsItemView(with: tableView, indexPath)
        case .teachers:
            return teacherItemView(with: tableView, indexPath)
        case .skillsTitle:
            return skillsTitleItemView(with: tableView, indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        estimateRowHeightStorage[indexPath] = cell.frame.size.height
    }
}


// MARK: - Custom Items

private extension CourseInfoAdapter {

    func descriptionItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoDescriptionItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoDescriptionItem.cellIdentifier(), for: indexPath) as? CourseInfoDescriptionItem
        cell?.configure(with: object?.title, object?.info, descriptionIsExpanded)
        cell?.tapToExpandExecuted = { [weak self] in
            self?.descriptionIsExpanded.toggle()
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }

        return cell!
    }

    func teacherItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoTeacherItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoTeacherItem.cellIdentifier(), for: indexPath) as? CourseInfoTeacherItem  
        if let owner = object?.owner {
            cell?.configure(with: owner)
        }
        return cell!
    }

    func skillsItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoSkillsItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoSkillsItem.cellIdentifier(), for: indexPath) as? CourseInfoSkillsItem
        cell?.configure(with: object?.course_skills ?? [])
        return cell!
    }

    func languageItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoLanguageItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoLanguageItem.cellIdentifier(), for: indexPath) as? CourseInfoLanguageItem
        cell?.configure(with: object?.language)

        return cell!
    }

    func skillsTitleItemView(with tableView: UITableView, _ indexPath: IndexPath) -> CourseInfoSkillTitleItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: CourseInfoSkillTitleItem.cellIdentifier(), for: indexPath) as? CourseInfoSkillTitleItem

        return cell!
    }
}
