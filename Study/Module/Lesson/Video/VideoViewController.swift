//
//  VideoViewController.swift
//  Study
//
//  Created by I on 3/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class VideoViewController: UIViewController {

    private lazy var videoPlaceholderImageView: UIImageView = UIImageView()
    private lazy var playButtonView: UIButton = UIButton()
    private var itemInfo: IndicatorInfo?

    init(with itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
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

// MARK: - IndicatorInfoProvider

extension VideoViewController: IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo!
    }
}


// MARK: - Builds

private extension VideoViewController {

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
