//
//  CourseInfoDescriptionItem.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class CourseInfoDescriptionItem: UITableViewCell {

    var tapToExpandExecuted: (()->())?

    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var descriptionLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoDescriptionItem")
    }

    func configure(with title: String?, _ description: String?, _ isExpanded: Bool) -> Void {

        titleLabelView.text = title

        let mainContentAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor]
        let moreContentAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor.withAlphaComponent(0.5)]
        if let description  = description {
            if isExpanded == false {
                if description.count >= 150
                {
                    let mainAttributedString = NSMutableAttributedString(string: "\(description.prefix(150))...", attributes: mainContentAttribute)
                    let moreAttributedString = NSMutableAttributedString(string: "More", attributes: moreContentAttribute)
                    mainAttributedString.append(moreAttributedString)

                    descriptionLabelView.attributedText = mainAttributedString
                }
                else{
                    descriptionLabelView.attributedText = NSMutableAttributedString(string: description, attributes: mainContentAttribute)
                }
            }
            else{
                descriptionLabelView.attributedText = NSMutableAttributedString(string: description, attributes: mainContentAttribute)
            }
        }
    }
}

private extension CourseInfoDescriptionItem {

    @objc
    func tapToExpand() -> Void {

        tapToExpandExecuted?()
    }
}

// MARK: - Builds

private extension CourseInfoDescriptionItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildGestures()
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
        descriptionLabelView.font = .systemFont(ofSize: 11.0)
        descriptionLabelView.numberOfLines = 0
    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, descriptionLabelView])
        titleLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(32)
            make.left.equalTo(20.0)
            make.right.equalTo(-27.0)
        }

        descriptionLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabelView.snp.bottom).offset(7.0)
            make.left.right.equalTo(titleLabelView)
            make.bottom.equalTo(-15.0)
        }
    }

    func buildGestures() -> Void {

        let tapGesturesForDescriptions = UITapGestureRecognizer(target: self, action: #selector(tapToExpand))
        self.addGestureRecognizer(tapGesturesForDescriptions)
    }
}
