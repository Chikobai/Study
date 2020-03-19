//
//  PostModel.swift
//  Study
//
//  Created by I on 3/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct TeacherModel: Decodable {

    let id: Int
    let email: String
    let first_name: String
    let last_name: String
}

struct CourseModel: Decodable {

    let id: Int
    let title: String
    let name: String
    let info: String
    let video_url: String
}

struct Post: Decodable{
    
    let id: Int
    let title: String
    let description: String
    let url: String
    let url_type: Int
    let viewed: Int
    let teacher: TeacherModel
    let course: CourseModel
    let post_type: Int
}
