//
//  VariantItem.swift
//  Study
//
//  Created by I on 3/10/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class VariantItem: UICollectionViewCell {

    private lazy var variantLabelView: UILabel = UILabel()
    private lazy var checkButtonView: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: VariantItem")
    }

    func configure(with variantText: String?) -> Void {

        self.variantLabelView.text = variantText
    }

    func setCorrect(with isSelected: Bool) {
        let icon: UIImage = isSelected ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "correct")
        self.backgroundColor = AppColor.main.uiColor
        self.checkButtonView.setImage(icon, for: .normal)
        self.variantLabelView.textColor = AppColor.white.uiColor
    }

    func setIncorrect(with isSelected: Bool) {
        let icon: UIImage = isSelected ? #imageLiteral(resourceName: "checked") : #imageLiteral(resourceName: "correct")
        self.backgroundColor = .red
        self.checkButtonView.setImage(icon, for: .normal)
        self.variantLabelView.textColor = AppColor.white.uiColor
    }
}

// MARK: - Builds

private extension VariantItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.lightGray.uiColor
        layer.cornerRadius = 10
        layer.masksToBounds = true

        //check button view
        checkButtonView.setImage(#imageLiteral(resourceName: "unchecked").withRenderingMode(.alwaysTemplate), for: .normal)
        checkButtonView.tintColor = AppColor.main.uiColor

        //variant label view
        variantLabelView.numberOfLines = 0
        variantLabelView.font = .boldSystemFont(ofSize: 14)
        variantLabelView.textColor = .darkGray
        variantLabelView.text = "What current trend do you hope will go on for a long time?"
        
    }

    func buildLayouts() -> Void {

        addSubviews(with: [checkButtonView, variantLabelView])

        snp.makeConstraints { (make) in
            make.width.equalTo(AppSize.Screen.width - 20.0)
        }

        checkButtonView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(23)
        }

        variantLabelView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(checkButtonView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }

    }
}
