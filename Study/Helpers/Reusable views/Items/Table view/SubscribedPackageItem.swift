//
//  SubscribedPackageItem.swift
//  Study
//
//  Created by I on 2/27/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class SubscribedPackageItem: UITableViewCell {

    private var verticalPadding: CGFloat = 25
    private var horizontalPadding: CGFloat = 11

    private(set) lazy var packageNameLabelView: UILabel = UILabel()
    private lazy var reviewButtonView: UIButton = UIButton()
    private lazy var progressView: UIProgressView = UIProgressView()
    private lazy var passedLessonsLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        buildFrames()
        buildShadows()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: Course) -> Void {

        packageNameLabelView.text = item.name
    }
}

// MARK: - Targets

private extension SubscribedPackageItem {

    @objc
    func reviewPressed() -> Void {
        print("reviewPressed")
    }
}

// MARK: - Builds

private extension SubscribedPackageItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none
        
        //content view
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = AppColor.white.uiColor

        //package name label view
        packageNameLabelView.text = "Discrete mathematics"
        packageNameLabelView.font = UIFont.systemFont(ofSize: 20)
        packageNameLabelView.numberOfLines = 2

        //review button view
        reviewButtonView.layer.cornerRadius = 14
        reviewButtonView.backgroundColor = AppColor.green.uiColor
        reviewButtonView.setTitle(AppTitle.MyCourses.review, for: .normal)

        //progress view
        progressView.progress = 0.3
        progressView.trackTintColor = AppColor.lightGray.uiColor
        progressView.progressTintColor = AppColor.main.uiColor

        //passed lessons label view
        passedLessonsLabelView.text = "7/44 lessons"
        passedLessonsLabelView.font = UIFont.systemFont(ofSize: 12)
        passedLessonsLabelView.textAlignment = .right
        passedLessonsLabelView.textColor = AppColor.darkGray.uiColor
    }

    func buildLayouts() -> Void {

        addSubviews(with: [packageNameLabelView, progressView, passedLessonsLabelView, reviewButtonView])
        
        reviewButtonView.snp.makeConstraints { (make) in
            make.centerY.equalTo(snp.bottom).offset(-verticalPadding)
            make.height.equalTo(31)
            make.right.equalTo(snp.centerX).offset(-30)
            make.left.equalToSuperview().offset(40)
        }

        packageNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(verticalPadding + 26)
            make.left.equalTo(horizontalPadding + 30)
            make.right.equalTo(-30 - horizontalPadding)
        }

        progressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(packageNameLabelView)
            make.top.equalTo(packageNameLabelView.snp.bottom).offset(26)
            make.height.equalTo(4)
        }

        passedLessonsLabelView.snp.makeConstraints { (make) in
            make.left.right.equalTo(packageNameLabelView)
            make.top.equalTo(progressView.snp.bottom).offset(26)
            make.bottom.equalTo(-26 - verticalPadding)
        }
    }

    func buildShadows() -> Void {
        let shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 16)
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowPath = shadowPath.cgPath
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: 25, left: 11, bottom: 25, right: 11))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }

    func buildTargets() -> Void {

        reviewButtonView.addTarget(self, action: #selector(reviewPressed), for: .touchUpInside)
    }
}
