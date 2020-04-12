//
//  GeneralPaginationModel.swift
//  Study
//
//  Created by I on 3/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

struct GeneralPaginationModel <T: Decodable>: Decodable {

    var count: Int
    var data: [T]
}
