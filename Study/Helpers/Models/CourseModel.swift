//
//  CourseModel.swift
//  Study
//
//  Created by I on 3/20/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct CourseOwner: Decodable {

    let id: Int
    let email: String
    let first_name: String
    let last_name: String
}

struct CourseSkill: Decodable {

    let code: Int
    let name: String
}

struct Course: Decodable {

    let id: Int
    let title: String
    let name: String
    let info: String
    let video_url: String
    let language: String
    let rating: Double?
    let user_counts: Int
    let is_my_course: Bool
    let module_counts: Int
    let owner: CourseOwner
    let course_skills: [CourseSkill]
}
