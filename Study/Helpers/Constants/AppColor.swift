//
//  AppColor.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit.UIColor

enum AppColor {

    case lightGray
    case darkGray
    case white
    case black
    case systemBlue
    case main
    case green
    case yellow

    var uiColor: UIColor {
        switch self {
        case .lightGray: return UIColor(rgb: 246, 246, 246)
        case .main: return UIColor(rgb: 53,170,230)
        case .white: return UIColor.white
        case .black: return UIColor.black
        case .systemBlue: return UIColor(rgb: 0, 122, 255)
        case .green: return UIColor.init(rgb: 75, 165, 73)
        case .darkGray: return UIColor.init(rgb: 45,42,42)
        case .yellow: return #colorLiteral(red: 1, green: 0.8549019608, blue: 0.1764705882, alpha: 1)
        }
    }

    var cgColor: CGColor { return uiColor.cgColor }
}

fileprivate extension UIColor {

    /// Initialize from integral RGB values (+ alpha channel in range 0-100)
    convenience init(rgb: UInt8..., alpha: UInt = 100) {
        self.init(
            red: CGFloat(rgb[0]) / 255,
            green: CGFloat(rgb[1]) / 255,
            blue: CGFloat(rgb[2]) / 255,
            alpha: CGFloat(min(alpha, 100)) / 100
        )
    }
}
