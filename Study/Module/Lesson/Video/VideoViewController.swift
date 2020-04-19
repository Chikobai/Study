//
//  VideoViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController, LessonDrawlable {

    private(set) lazy var videoPlaceholderImageView: UIImageView = UIImageView()
    private(set) lazy var playButtonView: UIButton = UIButton()
    private var lessonVideo: LessonPage

    init(with lessonVideo: LessonPage) {
        self.lessonVideo = lessonVideo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    deinit {
        print("DEINIT: VideoViewController")
    }
}

