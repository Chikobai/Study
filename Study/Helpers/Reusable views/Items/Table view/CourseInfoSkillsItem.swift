//
//  CourseInfoSkillsItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoSkillsItem: UITableViewCell {

    private lazy var skillsLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoSkillsItem")
    }

    func  configure(with skills: [String]) -> Void {

        let titleAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor]
        let skillsAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 9.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor.withAlphaComponent(0.5)]

        let titleAttributedString = NSMutableAttributedString.init(string: "Skills you will gain:   ", attributes: titleAttribute)

        skills.enumerated().forEach { (arg0) in

            let skill = (arg0.offset == skills.count - 1) ? arg0.element : "\(arg0.element), "

            let skillAttributedString = NSMutableAttributedString.init(string: skill, attributes: skillsAttribute)
            titleAttributedString.append(skillAttributedString)
        }

        skillsLabelView.attributedText = titleAttributedString
    }
}

// MARK: - Builds

private extension CourseInfoSkillsItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //skills label view
        skillsLabelView.numberOfLines = 0

    }

    func buildLayouts() -> Void {

        addSubview(skillsLabelView)
        skillsLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(29.0)
            make.right.equalTo(-29.0)
            make.centerY.equalToSuperview()
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
        }
    }
}
