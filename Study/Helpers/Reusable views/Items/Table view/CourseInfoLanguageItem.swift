//
//  CourseInfoLanguageItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoLanguageItem: UITableViewCell {

    private lazy var iconImageView: UIImageView = UIImageView()
    private lazy var basicLanguageLabelView: UILabel = UILabel()
    private lazy var subtitlesLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoLanguageItem")
    }

    func  configure(with language: String?) -> Void {

        basicLanguageLabelView.text = language
    }
}

// MARK: - Builds

private extension CourseInfoLanguageItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //icon image view
        iconImageView.image = #imageLiteral(resourceName: "language")

        //basic language label view
        basicLanguageLabelView.font = .boldSystemFont(ofSize: 13.0)
        basicLanguageLabelView.text = "English"

        //subtitles language view
        subtitlesLabelView.font = .boldSystemFont(ofSize: 11.0)
        subtitlesLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        subtitlesLabelView.text = "Subtitles: Russian, Kazakh, Turkish"
    }

    func buildLayouts() -> Void {

        addSubviews(with: [iconImageView, basicLanguageLabelView, subtitlesLabelView])
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(20.0)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(26.0)
        }

        basicLanguageLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10.0)
            make.top.equalTo(12.0)
            make.right.equalTo(-26.0)
        }

        subtitlesLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(basicLanguageLabelView.snp.bottom).offset(5)
            make.left.right.equalTo(basicLanguageLabelView)
            make.bottom.equalTo(-12.0)
        }
    }
}

