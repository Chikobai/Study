//
//  CourseInfoHeaderView.swift
//  Study
//
//  Created by I on 3/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import AVKit

class CourseInfoHeaderView: UIView {

    var player = AVPlayer()
    var playerController = AVPlayerViewController()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: CourseInfoHeaderView")
    }
}

// MARK: - Builds

private extension CourseInfoHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor
        isHidden = true

        //player view
        let videoURL = URL(string:"https://www.radiantmediaplayer.com/media/bbb-360p.mp4")!
        player = AVPlayer(url: videoURL)
        playerController.player = player
    }

    func buildLayouts() -> Void {

        playerController.view.frame = CGRect(x: 0, y: 5, width: self.frame.width, height: self.frame.height + 16)
        self.addSubview(playerController.view)
        playerController.view.backgroundColor = AppColor.white.uiColor
    }
}
