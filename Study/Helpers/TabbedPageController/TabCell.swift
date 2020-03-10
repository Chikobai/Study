//
//  TabCell.swift
//  Inviterkz
//
//  Created by Yerassyl Zhassuzakhov on 2/20/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import UIKit

class TabCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                setSelected()
            } else {
                setDeselected()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setDeselected()
    }

    func setSelected() {
        underline.isHidden = false
    }

    func setDeselected() {
        underline.isHidden = true
    }

    func setHasNotifications() {
        circle.isHidden = false
    }

    func clearNotifications() {
        circle.isHidden = true
    }

    private func setupViews() {
        contentView.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(underline)
        addSubview(circle)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        underline.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
        circle.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.height.width.equalTo(9)
        }
    }

    lazy var titleLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = .systemFont(ofSize: 14)

        return tl
    }()

    lazy var underline: UIView = {
        let ul = UIView()
        ul.backgroundColor = .lightGray
        ul.isHidden = true

        return ul
    }()

    lazy var circle: UIView = {
        let c = UIView()
        c.layer.cornerRadius = 4.5
        c.backgroundColor = .red
        c.isHidden = true

        return c
    }()
}
