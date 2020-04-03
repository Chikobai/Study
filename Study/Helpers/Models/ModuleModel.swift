//
//  ModuleModel.swift
//  Study
//
//  Created by I on 4/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct ModuleResult: Decodable {
    
    let count: Int
    let passed: Int
}

class Module: Decodable {

    let id: Int
    let title: String
    let result: ModuleResult
    let lessons: [Lesson]
    var isCollapsed: Bool?
}
