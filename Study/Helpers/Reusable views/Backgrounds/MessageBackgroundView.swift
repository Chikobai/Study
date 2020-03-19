//
//  MessageBackgroundView.swift
//  Delta
//
//  Created by I on 2/2/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class MessageBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupBackground()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() -> Void {

        addSubviews(with: [messageLabel])
        NSLayoutConstraint.activate([

            // Message Label constraint
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }

    func setupBackground() -> Void {

        backgroundColor = .white
        messageLabel.text = "Еще раз повторите, используя pull to refresh"
    }

    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 16)

        return view
    }()
}
