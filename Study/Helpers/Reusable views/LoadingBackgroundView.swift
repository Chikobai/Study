//
//  LoadingView.swift
//  Delta
//
//  Created by I on 2/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class LoadingBackgroundView: UIView {

    private lazy var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = AppColor.white.uiColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: AppSize.Screen.width),
            activityIndicator.heightAnchor.constraint(equalToConstant: AppSize.Screen.height)
        ])

        activityIndicator.color = AppColor.main.uiColor
        activityIndicator.startAnimating()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
