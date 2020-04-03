//
//  ReviewModel.swift
//  Study
//
//  Created by I on 4/3/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct Reviewer: Decodable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
}

struct Review: Decodable {

    let id: Int
    let text: String
    let rating: String
    let created: String
    let created_in_sec: Int
    let reviewer: Reviewer
}
