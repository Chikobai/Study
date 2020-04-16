//
//  LessonTypeModel.swift
//  Study
//
//  Created by I on 4/16/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct LessonQuestionVariant: Decodable {

    let id: Int
    let text: String?
    let is_true: Bool
}

struct LessonPage: Decodable {

    let id: Int
    let label: String?
    let order: Int
    let type: Int
    let answers: [LessonQuestionVariant]?
}

struct LessonPageResult: Decodable {

    let pages: [LessonPage]
}
