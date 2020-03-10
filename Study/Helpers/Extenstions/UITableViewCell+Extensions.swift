//
//  UITableViewCell+Extensions.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    static func cellIdentifier() -> String {

        return String.init(describing: self)
    }
}
