//
//  UICollectionViewCell+Ext.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {

    static func cellIdentifier() -> String {

        return String.init(describing: self)
    }
}
