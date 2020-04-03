//
//  LessonModel.swift
//  Study
//
//  Created by I on 4/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct LessonResult: Decodable {
    let count: Int
    let passed: Int
}

struct Lesson: Decodable {

    let id: Int
    let title: String
    let description: String
    let time: String
    let result: LessonResult
}
