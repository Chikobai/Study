//
//  CourseInfoDescriptionItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import ReadMoreTextView

class CourseInfoDescriptionItem: UITableViewCell {

    private lazy var titleLabelView: UILabel = UILabel()
    private(set) lazy var descriptionTextView: ReadMoreTextView = ReadMoreTextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        descriptionTextView.onSizeChange = {_ in}
        descriptionTextView.shouldTrim = true
    }

    deinit {
        print("DEINIT: CourseInfoDescriptionItem")
    }

    func configure(with title: String?, _ description: String?, _ isCollapsed: Bool) -> Void {

        titleLabelView.text = title
        descriptionTextView.text = description
        descriptionTextView.shouldTrim = !isCollapsed
        descriptionTextView.setNeedsUpdateTrim()
        descriptionTextView.layoutIfNeeded()
    }
}

// MARK: - Builds

private extension CourseInfoDescriptionItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        isUserInteractionEnabled = true
        selectionStyle = .none

        //title label view
        titleLabelView.font = .boldSystemFont(ofSize: 16.0)
        titleLabelView.numberOfLines = 0

        //description label view

        let attributedText = [
            NSAttributedString.Key.foregroundColor : AppColor.darkGray.uiColor.withAlphaComponent(0.7),
            NSAttributedString.Key.font :
                UIFont.systemFont(ofSize: 13.0)
        ]

        descriptionTextView.font = .systemFont(ofSize: 11.0)
        descriptionTextView.attributedReadMoreText = NSAttributedString(string: "...Read More", attributes: attributedText)
        descriptionTextView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: attributedText)

        descriptionTextView.maximumNumberOfLines = 3
        descriptionTextView.textAlignment = .left
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, descriptionTextView])
        titleLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.left.equalTo(20.0)
            make.right.equalTo(-20.0)
        }

        descriptionTextView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabelView.snp.bottom).offset(7.0)
            make.left.right.equalTo(titleLabelView)
            make.bottom.equalToSuperview()
        }
    }
}
