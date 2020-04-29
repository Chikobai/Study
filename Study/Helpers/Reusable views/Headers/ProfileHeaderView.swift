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
    private lazy var typeOfUserLabelView: UILabel = UILabel()
    private lazy var phoneNumberLabelView: UILabel = UILabel()
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
        photoImageView.image = #imageLiteral(resourceName: "photo")
        photoImageView.contentMode = .scaleAspectFill

        //user name label view
        userNameLabelView.text = "Jhon Jones"
        userNameLabelView.textAlignment = .center
        userNameLabelView.font = .boldSystemFont(ofSize: 18.byWidth())

        //type of user label view
        typeOfUserLabelView.text = "student"
        typeOfUserLabelView.textAlignment = .center
        typeOfUserLabelView.font = .systemFont(ofSize: 14.byWidth())
        typeOfUserLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)

        //phone number label view
        phoneNumberLabelView.text = "+7(747)377-80-99"
        phoneNumberLabelView.textAlignment = .center
        phoneNumberLabelView.font = .systemFont(ofSize: 13.byWidth())
        phoneNumberLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)

        //email label view
        emailLabelView.text = "160107084@stu.sdu.edu.kz"
        emailLabelView.textAlignment = .center
        emailLabelView.font = .systemFont(ofSize: 13.byWidth())
        emailLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [userNameLabelView, typeOfUserLabelView, photoImageView, phoneNumberLabelView, emailLabelView])
        userNameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(10.byWidth())
            make.centerX.equalToSuperview()
        }

        typeOfUserLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabelView.snp.bottom)
            make.centerX.equalToSuperview()
        }

        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(typeOfUserLabelView.snp.bottom).offset(20.byWidth())
            make.centerX.equalToSuperview()
            make.height.width.equalTo(110.byWidth())
        }

        phoneNumberLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom).offset(10.byWidth())
            make.centerX.equalToSuperview()
        }

        emailLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNumberLabelView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}
