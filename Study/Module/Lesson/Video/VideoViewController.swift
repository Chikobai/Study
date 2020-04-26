//
//  VideoViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: UIViewController, LessonDrawlable {

    private(set) var player: AVPlayer
    private(set) var playerController = AVPlayerViewController()
    private(set) lazy var coverVideoView: UIView = UIView()

    private var lessonVideo: LessonPage

    init(with lessonVideo: LessonPage) {
        self.lessonVideo = lessonVideo
        let videoURL = URL(string:"https://www.radiantmediaplayer.com/media/bbb-360p.mp4")!
        self.player = AVPlayer(url: videoURL)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        add(playerController, onView: coverVideoView)
        build()
    }

    deinit {
        print("DEINIT: VideoViewController")
    }
}

