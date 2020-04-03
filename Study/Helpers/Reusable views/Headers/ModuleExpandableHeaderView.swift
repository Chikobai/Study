//
//  ModuleExpandableHeaderView.swift
//  Study
//
//  Created by I on 3/1/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class ModuleExpandableHeaderView: UIView {

    private(set) lazy var sectionLabelView: UILabel = UILabel()
    private lazy var chapterLabelView: UILabel = UILabel()
    private lazy var scoreLabelView: UILabel = UILabel()
    private lazy var downloadButtonView: UIButton = UIButton()
    private lazy var toExpandButtonView: UIButton = UIButton()
    private lazy var separatorLineView: UIView = UIView()

    private var isCollapsed: Bool? = true

    var executeTappedEvent: (()->())?

    init() {
        super.init(frame: .zero)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: ModuleExpandableHeaderView")
    }

    func configure(with module: Module) -> Void {

        chapterLabelView.text = module.title
        isCollapsed = module.isCollapsed
        scoreLabelView.text = "\(module.result.passed)/\(module.result.count) баллов"
        
        let image = (isCollapsed ?? true) ? #imageLiteral(resourceName: "up-and-down 5") : #imageLiteral(resourceName: "up-and-down 17")
        toExpandButtonView.setImage(image, for: .normal)
    }
}

private extension ModuleExpandableHeaderView {

    @objc
    func tappedToExpand(_ sender: UITapGestureRecognizer) -> Void {

        isCollapsed?.toggle()
        let image = (isCollapsed ?? true) ? #imageLiteral(resourceName: "up-and-down 5") : #imageLiteral(resourceName: "up-and-down 17")
        toExpandButtonView.setImage(image, for: .normal)
        executeTappedEvent?()
    }
}

// MARK: - Builds

private extension ModuleExpandableHeaderView {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildGestures()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.white.uiColor

        //section label view
        sectionLabelView.font = .systemFont(ofSize: 15.0)
        sectionLabelView.textColor = AppColor.black.uiColor

        //chapter label view
        chapterLabelView.font = .systemFont(ofSize: 15.0)
        chapterLabelView.textColor = AppColor.black.uiColor

        //score label view
        scoreLabelView.textColor = AppColor.black.uiColor.withAlphaComponent(0.5)
        scoreLabelView.font = .systemFont(ofSize: 10.0)

        //to expand button view
        toExpandButtonView.setImage(#imageLiteral(resourceName: "up-and-down 5"), for: .normal)

        //download button view
        downloadButtonView.setImage(#imageLiteral(resourceName: "cloud-computing 3"), for: .normal)

        //separator line view
        separatorLineView.backgroundColor = AppColor.black.uiColor.withAlphaComponent(0.2)
    }

    func buildLayouts() -> Void {

        addSubviews(with: [sectionLabelView, chapterLabelView, scoreLabelView, downloadButtonView, toExpandButtonView, separatorLineView])

        sectionLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(15.0)
            make.left.equalTo(30.0)
        }

        chapterLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(sectionLabelView)
            make.left.equalTo(sectionLabelView.snp.right).offset(20.0)
        }

        scoreLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(chapterLabelView)
            make.top.equalTo(chapterLabelView.snp.bottom).offset(9.0)
        }

        toExpandButtonView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-21.0)
            make.width.height.equalTo(20.0)
        }

        downloadButtonView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(22.0)
            make.height.equalTo(20.0)
            make.right.equalTo(toExpandButtonView.snp.left).offset(-20.0)
        }

        separatorLineView.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(0.8)
        }
    }

    func buildGestures() -> Void {

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tappedToExpand))
        self.addGestureRecognizer(tap)
    }
}
