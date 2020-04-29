//
//  PostItem.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import AVKit
import ReadMoreTextView

class PostItem: UITableViewCell {

    var player = AVPlayer()
    var playerController = AVPlayerViewController()

    private lazy var videoView: UIView = UIView()
    private lazy var postedUserImageView: UIImageView = UIImageView()
    private lazy var postedUserNameLabelView: UILabel = UILabel()
    private lazy var postNameLabelView: UILabel = UILabel()
    private(set) lazy var postDescriptionLabelView: ReadMoreTextView = ReadMoreTextView()
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

    override func prepareForReuse() {
        super.prepareForReuse()

        postDescriptionLabelView.onSizeChange = {_ in}
        postDescriptionLabelView.shouldTrim = true
    }

    func configure(with data: Post, _ isCollapsed: Bool) -> Void {

        postedUserNameLabelView.text = data.teacher.first_name + " " + data.teacher.last_name
        postNameLabelView.text = data.title

        postDescriptionLabelView.text = data.description
        postDescriptionLabelView.shouldTrim = !isCollapsed
        postDescriptionLabelView.setNeedsUpdateTrim()
        postDescriptionLabelView.layoutIfNeeded()
    }
}

private extension PostItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //videoView
        let videoURL = URL(string:"https://www.radiantmediaplayer.com/media/bbb-360p.mp4")!
        playerController.view.backgroundColor = AppColor.white.uiColor
        player = AVPlayer(url: videoURL)
        playerController.player = player

        postedUserImageView.image = #imageLiteral(resourceName: "photo")
        postedUserImageView.clipsToBounds = true
        postedUserImageView.layer.cornerRadius = 18.byWidth()

        //posted user name label view
        postedUserNameLabelView.font = .systemFont(ofSize: 14.byWidth())

        //post name label view
        postNameLabelView.font = .boldSystemFont(ofSize: 20.byWidth())
        postNameLabelView.numberOfLines = 2

        //posted time label view
        postedTimeLabelView.font = .systemFont(ofSize: 8.byWidth())
        postedTimeLabelView.text = "3 hours ago"
        postedTimeLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)

        //post description label view
        let attributedText = [
            NSAttributedString.Key.foregroundColor : AppColor.darkGray.uiColor.withAlphaComponent(0.7),
            NSAttributedString.Key.font :
                UIFont.systemFont(ofSize: 13.byWidth())
        ]

        postDescriptionLabelView.attributedReadMoreText = NSAttributedString(string: "...Read More", attributes: attributedText)
        postDescriptionLabelView.attributedReadLessText = NSAttributedString(string: " Read less", attributes: attributedText)

        postDescriptionLabelView.maximumNumberOfLines = 3
        postDescriptionLabelView.textAlignment = .left
    }

    func buildLayouts() -> Void {

        addSubviews(with: [postedUserImageView, postedUserNameLabelView, videoView, postNameLabelView, postDescriptionLabelView, postedTimeLabelView])

        self.videoView.addSubview(playerController.view)

        postedUserImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(6.byWidth())
            make.width.height.equalTo(36.byWidth())
        }

        postedUserNameLabelView.snp.makeConstraints { (make) in
            make.centerY.equalTo(postedUserImageView)
            make.left.equalTo(postedUserImageView.snp.right).offset(11.byWidth())
            make.right.equalTo(-6.byWidth())
        }

        videoView.snp.makeConstraints { (make) in
            make.top.equalTo(postedUserImageView.snp.bottom).offset(7.byWidth())
            make.left.right.equalToSuperview()
            make.height.equalTo(195.byWidth())
        }

        postNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom).offset(30.byWidth())
            make.left.equalTo(15.byWidth())
            make.right.equalTo(-15.byWidth())
        }

        postDescriptionLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(postNameLabelView.snp.bottom).offset(7.byWidth())
            make.left.right.equalTo(postNameLabelView)
        }

        postedTimeLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(postDescriptionLabelView.snp.bottom).offset(8.byWidth())
            make.left.right.equalTo(postDescriptionLabelView)
            make.bottom.equalTo(-15.byWidth())
        }

        playerController.view.frame = CGRect(x: 0, y: 0, width: self.videoView.frame.width, height: self.videoView.frame.height + 16.byWidth())
    }
}
