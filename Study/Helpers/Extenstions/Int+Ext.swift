//
//  Int+Ext.swift
//  Delta
//
//  Created by I on 12/9/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension Int {

    func byWidth() -> CGFloat {
        return  AppSize.Screen.width / (375 / CGFloat(self))
    }

    func byHeight() -> CGFloat {
        return  AppSize.Screen.height / (812 / CGFloat(self))
    }
}
