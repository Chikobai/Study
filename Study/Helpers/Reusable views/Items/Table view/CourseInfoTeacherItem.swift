//
//  CourseInfoTeacherItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoTeacherItem: UITableViewCell {

    private var photoImageView: UIImageView = UIImageView()
    private var nameLabelView: UILabel = UILabel()
    private var experienceLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoTeacherItem")
    }

    func configure(with owner: CourseOwner) -> Void {
        nameLabelView.text = "\(owner.first_name) \(owner.last_name)"
    }
}

// MARK: - Builds

private extension CourseInfoTeacherItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //photo image view
        photoImageView.image = #imageLiteral(resourceName: "Ellipse 18")
        photoImageView.layer.cornerRadius = 20.byWidth()
        photoImageView.clipsToBounds = true

        //name label view
        nameLabelView.font = .systemFont(ofSize: 13.byWidth())
        nameLabelView.text = "Nemchenko M."

        //experience label view
        experienceLabelView.font = .systemFont(ofSize: 11.byWidth())
        experienceLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        experienceLabelView.text = "experience: 13 years"
    }

    func buildLayouts() -> Void {

        addSubviews(with: [photoImageView, nameLabelView, experienceLabelView])
        photoImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20.byWidth())
            make.top.equalTo(15.byWidth())
            make.width.height.equalTo(40.byWidth())
            make.bottom.equalTo(-12.byWidth())
        }

        nameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView).offset(3.byWidth())
            make.left.equalTo(photoImageView.snp.right).offset(13.byWidth())
            make.right.equalTo(-13.byWidth())
        }

        experienceLabelView.snp.makeConstraints { (make) in
            make.bottom.equalTo(photoImageView.snp.bottom).offset(-3.byWidth())
            make.right.left.equalTo(nameLabelView)
        }
    }
}
