//
//  PostItem.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class PostItem: UITableViewCell {

    var descriptionLabelGestureNotified: (()->())?

    private lazy var videoPlaceholderImageView: UIImageView = UIImageView()
    private lazy var postedUserImageView: UIImageView = UIImageView()
    private lazy var postedUserNameLabelView: UILabel = UILabel()
    private lazy var playButtonView: UIButton = UIButton()
    private lazy var postNameLabelView: UILabel = UILabel()
    private(set) lazy var postDescriptionLabelView: UILabel = UILabel()
    private lazy var postedTimeLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: PostItem")
    }

    func configure(with data: ExpandedLabel) -> Void {

        let mainContentAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor]
        let moreContentAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0), NSAttributedString.Key.foregroundColor: AppColor.black.uiColor.withAlphaComponent(0.5)]

        if data.collapsed == true {
            if data.text.count >= 150
            {
                let mainAttributedString = NSMutableAttributedString(string: "\(data.text.prefix(150))...", attributes: mainContentAttribute)
                let moreAttributedString = NSMutableAttributedString(string: "More", attributes: moreContentAttribute)
                mainAttributedString.append(moreAttributedString)

                postDescriptionLabelView.attributedText = mainAttributedString
            }
            else{
                postDescriptionLabelView.attributedText = NSMutableAttributedString(string: data.text, attributes: mainContentAttribute)
            }
        }
        else{
            postDescriptionLabelView.attributedText = NSMutableAttributedString(string: data.text, attributes: mainContentAttribute)
        }
    }
}

private extension PostItem {

    @objc
    func descriptionLabelTapped(_ sender: UITapGestureRecognizer) -> Void {
        
        descriptionLabelGestureNotified?()
    }
}

private extension PostItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildGestures()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //video placeholder image view
        videoPlaceholderImageView.image = #imageLiteral(resourceName: "background")

        //play button view
        playButtonView.setImage(#imageLiteral(resourceName: "play-button (2) 6"), for: .normal)
        playButtonView.backgroundColor = .clear
        playButtonView.layer.cornerRadius = 18.0
        playButtonView.clipsToBounds = true

        //posted user image view
        postedUserImageView.image = #imageLiteral(resourceName: "photo")
        postedUserImageView.clipsToBounds = true
        postedUserImageView.layer.cornerRadius = 18.0

        //posted user name label view
        postedUserNameLabelView.text = "Nemchenko A."
        postedUserNameLabelView.font = .systemFont(ofSize: 14.0)

        //post name label view
        postNameLabelView.text = "Discrete mathematics"
        postNameLabelView.font = .boldSystemFont(ofSize: 20.0)
        postNameLabelView.numberOfLines = 2

        //post description label view
        postDescriptionLabelView.text = "Discrete mathematics is the study of mathematical structures...More"
        postDescriptionLabelView.numberOfLines = 0
        postDescriptionLabelView.isUserInteractionEnabled = true

        //posted time label view
        postedTimeLabelView.font = .systemFont(ofSize: 8)
        postedTimeLabelView.text = "3 hours ago"
        postedTimeLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [postedUserImageView, postedUserNameLabelView, videoPlaceholderImageView, playButtonView, postNameLabelView, postDescriptionLabelView, postedTimeLabelView])

        postedUserImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(6.0)
            make.width.height.equalTo(36.0)
        }

        postedUserNameLabelView.snp.makeConstraints { (make) in
            make.centerY.equalTo(postedUserImageView)
            make.left.equalTo(postedUserImageView.snp.right).offset(11.0)
            make.right.equalTo(-6.0)
        }

        videoPlaceholderImageView.snp.makeConstraints { (make) in
            make.top.equalTo(postedUserImageView.snp.bottom).offset(7.0)
            make.left.right.equalToSuperview()
            make.height.equalTo(195.0)
        }

        playButtonView.snp.makeConstraints { (make) in
            make.center.equalTo(videoPlaceholderImageView)
            make.height.width.equalTo(36.0)
        }

        postNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(videoPlaceholderImageView.snp.bottom).offset(15.0)
            make.left.equalTo(25.0)
            make.right.equalTo(-25.0)
        }

        postDescriptionLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(postNameLabelView.snp.bottom).offset(7.0)
            make.left.right.equalTo(postNameLabelView)
        }

        postedTimeLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(postDescriptionLabelView.snp.bottom).offset(8)
            make.left.right.equalTo(postDescriptionLabelView)
            make.bottom.equalTo(-15.0)
        }
    }

    func buildGestures() -> Void {

        let tapGesturesForDescriptions = UITapGestureRecognizer(target: self, action: #selector(descriptionLabelTapped))
        postDescriptionLabelView.addGestureRecognizer(tapGesturesForDescriptions)
    }
}
