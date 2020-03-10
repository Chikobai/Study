//
//  MessageHeaderView.swift
//  Study
//
//  Created by I on 2/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MessageHeaderView: UIView {

    private lazy var titleLabelView: UILabel = UILabel()

    init(with title: String) {
        super.init(frame: .zero)
        titleLabelView.text = title
        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: MessageHeaderView")
    }

}

// MARK: - Builds

private extension MessageHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //title label view
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.font = .systemFont(ofSize: 9)
        titleLabelView.textAlignment = .center
        titleLabelView.numberOfLines = 0
    }

    func buildLayouts() -> Void {

        addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.left.top.equalTo(16.0)
            make.right.bottom.equalTo(-16.0)
        }
    }
}
