//
//  PaddingLabel.swift
//  Jiber
//
//  Created by I on 10/23/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation

import Foundation
import UIKit

final class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
