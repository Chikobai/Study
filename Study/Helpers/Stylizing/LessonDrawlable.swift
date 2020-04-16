//
//  LessonDrawlable.swift
//  Study
//
//  Created by I on 4/16/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

protocol LessonDrawlable {}

extension LessonDrawlable where Self: LessonViewController {

    func build() -> Void {

        buildViews()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        // view pager
        viewPager = ViewPager(containerView: self.view)
        
    }
}

extension LessonDrawlable where Self: QuestionsViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //questions label view
        questionsLabelView.font = .boldSystemFont(ofSize: 14)
        questionsLabelView.textAlignment = .center
        questionsLabelView.text = "If you could switch two movie characters, what switch would lead to the most inappropriate movies?"
        questionsLabelView.numberOfLines = 0
        questionsLabelView.sizeToFit()

        //variant collection view

    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [questionsLabelView, variantCollectionView])
        questionsLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.0)
            make.centerX.equalToSuperview()
            make.left.equalTo(15.0)
            make.right.equalTo(-15.0)
        }

        variantCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(questionsLabelView.snp.bottom).offset(30)
            make.bottom.centerX.width.equalToSuperview()
        }
    }
}

extension LessonDrawlable where Self: VideoViewController {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = AppColor.white.uiColor

        //video placeholder image view
        videoPlaceholderImageView.backgroundColor = AppColor.main.uiColor

        //play button view
        playButtonView.setImage(#imageLiteral(resourceName: "play-button (2) 6"), for: .normal)
        playButtonView.backgroundColor = .clear
        playButtonView.layer.cornerRadius = 18.0
        playButtonView.clipsToBounds = true
    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [videoPlaceholderImageView, playButtonView])
        videoPlaceholderImageView.snp.makeConstraints { (make) in
            make.left.right.centerY.centerX.equalToSuperview()
            make.height.equalTo(230.0)
        }

        playButtonView.snp.makeConstraints { (make) in
            make.center.equalTo(videoPlaceholderImageView)
            make.height.width.equalTo(36.0)
        }
    }
}
