//
//  SkillItem.swift
//  Study
//
//  Created by I on 3/13/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class Skilltem: UICollectionViewCell {

    private lazy var titleLabelView: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: Skilltem")
    }

    func configure(with title: String) -> Void {
        titleLabelView.text = title
    }
}

// MARK: - Builds

private extension Skilltem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.main.uiColor.withAlphaComponent(0.7)
        layer.cornerRadius = 8
        clipsToBounds = true

        //title label view
        titleLabelView.font = UIFont.systemFont(ofSize: 12.0)
        titleLabelView.textColor = AppColor.white.uiColor
        titleLabelView.textAlignment = .center
    }

    func buildLayouts() -> Void {

        addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
