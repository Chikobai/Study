//
//  CourseInfoSkillTitleItem.swift
//  Study
//
//  Created by I on 4/25/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoSkillTitleItem: UITableViewCell {

    private lazy var skillsLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Builds

private extension CourseInfoSkillTitleItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //skills label view
        skillsLabelView.text = AppTitle.CourseDetails.skills
        skillsLabelView.numberOfLines =  2
        skillsLabelView.font = .boldSystemFont(ofSize: 16.byWidth())

    }

    func buildLayouts() -> Void {

        addSubviews(with: [skillsLabelView])

        skillsLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(7.byWidth())
            make.left.equalTo(20.byWidth())
            make.right.equalTo(-20.byWidth())
            make.bottom.equalTo(-7.byWidth())
        }
    }
}
