//
//  LessonDrawlable.swift
//  Study
//
//  Created by I on 4/16/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit
import AVKit

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
        questionsLabelView.font = .boldSystemFont(ofSize: 14.byWidth())
        questionsLabelView.textAlignment = .center
        questionsLabelView.text = lessonQuestion.label
        questionsLabelView.numberOfLines = 0
        questionsLabelView.sizeToFit()

        //variant collection view
        variantCollectionView.configure(with: lessonQuestion.answers ?? [])

    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [questionsLabelView, variantCollectionView])

        questionsLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30.byWidth())
            make.centerX.equalToSuperview()
            make.left.equalTo(15.byWidth())
            make.right.equalTo(-15.byWidth())
        }

        variantCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(questionsLabelView.snp.bottom).offset(30.byWidth())
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

        //cover video view
        coverVideoView.backgroundColor = AppColor.main.uiColor

        //video player
        playerController.view.backgroundColor = AppColor.white.uiColor
        playerController.player = player
    }

    func buildLayouts() -> Void {

        view.addSubviews(with: [coverVideoView])
        coverVideoView.snp.makeConstraints { (make) in
            make.left.right.centerY.centerX.equalToSuperview()
            make.height.equalTo(230.0)
        }
    }
}
