//
//  MessageItem.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MessageItem: UITableViewCell {

    private lazy var titleLabelView: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: MessageItem")
    }

    func configure(with title: String?, _ alignment: NSTextAlignment) -> Void {

        self.titleLabelView.text = title
        self.titleLabelView.textAlignment = alignment
    }

}

// MARK: - Builds

private extension MessageItem {

    func build() -> Void {

        buildViews()
        buildLayout()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //title label view
        titleLabelView.font = .systemFont(ofSize: 17.0)
        titleLabelView.numberOfLines = 0
    }

    func buildLayout() -> Void {

        addSubview(titleLabelView)
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(16.0)
            make.right.equalTo(-16.0)
            make.top.equalTo(10.0)
            make.bottom.equalTo(-10.0)
        }
    }
}
