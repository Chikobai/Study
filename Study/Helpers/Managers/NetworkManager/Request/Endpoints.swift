//
//  Endpoints.swift
//  Hiromant
//
//  Created by Yerassyl Zhassuzakhov on 4/8/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Alamofire

enum Endpoints: EndPointType {

    //GET
    case posts(limit: Int, offset: Int)
    case courses(limit: Int, offset: Int)
    case modules(id: Int, limit: Int, offset: Int)
    case reviews(id: Int, limit: Int, offset: Int)
    case info(id: Int)
    case subscribedCourses

    //POST


    //PUT


    //DEL
    
    var baseURL: String {
        return "http://usernotfound.pythonanywhere.com"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        default:
            return  .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .posts(let limit, let offset),
             .courses(let limit, let offset),
             .modules(_, let limit, let offset),
             .reviews(_, let limit, let offset):
            return .requestWithParameters(parameters: ["offset": offset, "limit": limit])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .posts,
             .subscribedCourses,
             .courses,
             .modules,
             .reviews,
             .info:
            return ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im11a2hpdGJveXNAZ21haWwuY29tIiwiaWQiOjIsImlhdCI6MTU4Mjc4OTgyMn0.BTxSailhu2VMHIrUurZdjmzusv2DAa0i4l0OIrD7AkE"]
        }
    }
    
    var path: String {
        switch self {
        case .posts(_, _):
            return "/api/v1/posts/"
        case .subscribedCourses:
            return "/api/v1/mycourses/"
        case .courses:
            return "/api/v1/courses/"
        case .modules(let id, _, _):
            return "/api/v1/course/\(id)/modules/"
        case .reviews(let id, _, _):
            return "/api/v1/course/\(id)/reviews/"
        case .info(let id):
            return "\(id)"
        }
    }
}
