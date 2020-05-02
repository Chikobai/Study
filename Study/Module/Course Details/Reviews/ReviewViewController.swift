//
//  ReviewViewController.swift
//  Study
//
//  Created by I on 5/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import Cosmos

class ReviewViewController: UIViewController {

    private var courseIdentifier: Int

    private lazy var profileImageView: UIImageView = UIImageView()
    private lazy var usernameLabelView: UILabel = UILabel()
    private lazy var ratingView: CosmosView = CosmosView()
    private lazy var commentTextView: UITextView = UITextView()
    private lazy var submitButtonView: FilledButton = FilledButton()

    init(with courseIdentifier: Int) {
        self.courseIdentifier = courseIdentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }
}

// MARK: - Targets

extension ReviewViewController {

    @objc
    private func cancelPressed() -> Void {

        self.dismiss(animated: true, completion: nil)
    }

    @objc
    private func submitCommentPressed() -> Void {
        let commentText = commentTextView.text.removingWhitespaces()
        let rating = Int(ratingView.rating)
        if (commentText.isEmpty == false) {
            let params = [
                AppKey.CourseDetails.comment: commentText, AppKey.CourseDetails.rating: "\(rating)"
            ]
            self.submitButtonView.startLoading()
            Request.shared.sendComment(with: courseIdentifier, params, complitionHandler: { (message) in
                self.submitButtonView.stopLoading()
                self.display(with: message, completionHandler: {
                    self.dismiss(animated: true, completion: nil)
                })
            }) { (message) in
                self.submitButtonView.stopLoading()
                self.display(with: message, completionHandler: nil)
            }
        }
        else {
            self.display(with: AppErrorMessage.CourseDetails.reviewIsEmpty, completionHandler: nil)
        }
    }
}

// MARK: - Builds

extension ReviewViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //profile image view
        profileImageView.layer.cornerRadius = 50.byWidth()
        profileImageView.image = #imageLiteral(resourceName: "Ellipse 18")

        //username label view
        usernameLabelView.text = "Orynbassar Shyngys"
        usernameLabelView.font = .systemFont(ofSize: 23.byWidth())
        usernameLabelView.textColor = AppColor.black.uiColor
        usernameLabelView.textAlignment = .center
        usernameLabelView.numberOfLines = 0
        usernameLabelView.sizeToFit()

        //rating view
        ratingView.settings.filledImage = #imageLiteral(resourceName: "star")
        ratingView.settings.emptyImage = #imageLiteral(resourceName: "unstart")
        ratingView.settings.starSize = Double(20.byWidth())

        //comment text view
        let insetsValue = 20.byWidth()
        commentTextView.layer.cornerRadius = 8.byWidth()
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = AppColor.main.cgColor
        commentTextView.font = .systemFont(ofSize: 14.byWidth())
        commentTextView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        commentTextView.tintColor = AppColor.main.uiColor
        commentTextView.textContainerInset = .init(top: insetsValue, left: insetsValue, bottom: insetsValue, right: insetsValue)

        //submit comment button view
        submitButtonView.setTitle(AppTitle.CourseDetails.send, for: .normal)

        //navigation view
        navigationItem.title = AppTitle.CourseDetails.writeAReview
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "cancel"), style: .plain, target: self, action: #selector(cancelPressed))
    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [profileImageView, usernameLabelView, ratingView, commentTextView, submitButtonView])
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(75.byWidth())
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100.byWidth())
        }

        usernameLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(15.byWidth())
            make.centerX.equalToSuperview()
            make.left.equalTo(20.byWidth())
            make.right.equalTo(-20.byWidth())
        }

        ratingView.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabelView.snp.bottom).offset(30.byWidth())
            make.centerX.equalToSuperview()
        }

        commentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(ratingView.snp.bottom).offset(30.byWidth())
            make.centerX.equalToSuperview()
            make.left.equalTo(20.byWidth())
            make.right.equalTo(-20.byWidth())
            make.height.equalTo(200.byWidth())
        }

        submitButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(commentTextView.snp.bottom).offset(30.byWidth())
            make.left.equalTo(20.byWidth())
            make.right.equalTo(-20.byWidth())
            make.height.equalTo(50.byWidth())
        }
    }

    func buildServices() -> Void {

        submitButtonView.addTarget(self, action: #selector(submitCommentPressed), for: .touchUpInside)
    }
}
