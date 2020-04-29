//
//  ModuleItem.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class LessonItem: UITableViewCell {

    private lazy var topicImageView: UIImageView = UIImageView()
    private lazy var topicLabelView: UILabel = UILabel()
    private lazy var scoreLabelView: UILabel = UILabel()
    private lazy var durationLabelView: UILabel = UILabel()
    private lazy var populationLabelView: UILabel = UILabel()
    private lazy var likedLabelView: UILabel = UILabel()
    private lazy var informationStackView: UIStackView = UIStackView()
    private lazy var separatorLineView: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: LessonItem")
    }

    func configure(with lesson: Lesson) -> Void {

        topicLabelView.text = lesson.title
        scoreLabelView.text = "\(lesson.result.passed)/\(lesson.result.count) баллов"
        durationLabelView.text = "\(lesson.time) мин"
        populationLabelView.text = "36 человеков"
    }
}

// MARK: - Builds

private extension LessonItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        selectionStyle = .none

        //topic image view
        topicImageView.layer.cornerRadius = 3.byWidth()
        topicImageView.clipsToBounds = true
        topicImageView.image = #imageLiteral(resourceName: "topic")

        //topic label view
        topicLabelView.font = .systemFont(ofSize: 13.byWidth())
        topicLabelView.textColor = AppColor.black.uiColor

        //information stack view
        informationStackView.alignment = .fill
        informationStackView.distribution = .equalSpacing
        informationStackView.axis = .horizontal
        informationStackView.spacing = 20.byWidth()

        //score label view
        scoreLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        scoreLabelView.font = .systemFont(ofSize: 10.byWidth())

        //duration label view
        durationLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        durationLabelView.font = .systemFont(ofSize: 10.byWidth())

        //population label view
        populationLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        populationLabelView.font = .systemFont(ofSize: 10.byWidth())

        //liked label view
        likedLabelView.text = "36 нравиться"
        likedLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        likedLabelView.font = .systemFont(ofSize: 10.byWidth())

        //separator line view
        separatorLineView.backgroundColor = AppColor.black.uiColor.withAlphaComponent(0.2)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [topicImageView, topicLabelView, informationStackView, separatorLineView])
        informationStackView.addArrangedSubviews(with: [scoreLabelView, durationLabelView, populationLabelView, likedLabelView])

        separatorLineView.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(0.8)
        }

        topicImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(2.byWidth())
            make.bottom.equalTo(separatorLineView.snp.top).offset(-2.byWidth())
            make.height.width.equalTo(60.byWidth()).priority(999)
        }

        topicLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(16.byWidth())
            make.left.equalTo(topicImageView.snp.right).offset(18.byWidth())
            make.right.equalTo(-18.byWidth())
        }

        informationStackView.snp.makeConstraints { (make) in
            make.left.equalTo(topicLabelView.snp.left)
            make.height.equalTo(20.byWidth())
            make.top.equalTo(topicLabelView.snp.bottom).offset(7.byWidth())
        }
    }
}
