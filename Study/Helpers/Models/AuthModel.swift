//
//  Login.swift
//  Study
//
//  Created by I on 4/5/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct Auth: Decodable {

    let message: String?
    let success: Bool?
    let token: String?
}

struct Login: Decodable {

    let message: String?
    let success: Bool?
    let token: String?
    let profile: Profile
}
