//
//  UIStackView+Extensions.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {

    func addArrangedSubviews(with views: [UIView]) -> Void {

        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
}
