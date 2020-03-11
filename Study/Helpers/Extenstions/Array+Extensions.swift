//
//  Array+Extensions.swift
//  Study
//
//  Created by I on 3/11/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

extension Array {
    func safeValue(at index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
