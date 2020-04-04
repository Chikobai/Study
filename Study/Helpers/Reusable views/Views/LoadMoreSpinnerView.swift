
//
//  LoadMoreSpinnerView.swift
//  Study
//
//  Created by I on 3/21/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class LoadMoreSpinnerView: UIActivityIndicatorView {

    init() {
        super.init(frame: .zero)

        frame.size.height = 44.0
        color = .black
        startAnimating()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
