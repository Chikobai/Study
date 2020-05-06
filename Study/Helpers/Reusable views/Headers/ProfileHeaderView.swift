//
//  ProfileHeaderView.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    private lazy var photoImageView: UIImageView = UIImageView()
    private lazy var userNameLabelView: UILabel = UILabel()
    private lazy var emailLabelView: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: ProfileHeaderView")
    }

    func setProfileObject(with object: Profile) -> Void {
        self.userNameLabelView.text = object.first_name + " " + object.last_name
        self.emailLabelView.text = object.email
        self.photoImageView.kf.indicatorType = .activity
        self.photoImageView.kf.setImage(with: URL(string: object.image))
    }
}

// MARK: - Builds

private extension ProfileHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = .clear

        //photo image view
        photoImageView.layer.cornerRadius = 55.byWidth()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill

        //user name label view
        userNameLabelView.textAlignment = .center
        userNameLabelView.font = .boldSystemFont(ofSize: 18.byWidth())

        //email label view
        emailLabelView.textAlignment = .center
        emailLabelView.font = .systemFont(ofSize: 13.byWidth())
        emailLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [userNameLabelView, photoImageView, emailLabelView])
        userNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(10.byWidth())
            make.centerX.equalToSuperview()
        }

        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabelView.snp.bottom).offset(20.byWidth())
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110.byWidth())
        }

        emailLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom).offset(20.byWidth())
            make.centerX.equalToSuperview()
        }
    }
}
