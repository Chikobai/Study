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

    case login(params: [String: String])
    case registration(params: [String: String])
    case join( course_id: Int)

    //PUT


    //DEL
    
    var baseURL: String {
        return "http://usernotfound.pythonanywhere.com"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .join,
             .login,
             .registration:
            return .post
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
            return .requestWithParameters(parameters: [
                "page": offset, "limit": limit
            ])
        case .join(let course_id):
            return .requestWithParameters(parameters: [
                "course_id": course_id
            ])
        case .login(let params),
             .registration(let params):
            return .requestAuthorizationWithParameters(parameters: params)
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
             .info,
             .join:
            return ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im9yeW5iYXNzYXIuc2h5bmd5c0BnbWFpbC5jb20iLCJpZCI6MTcsImlhdCI6MTU4NjQxMTYxNn0.OE0F6ZVNjrYbit8LERwv0Gkv3KZ8ECtS6puSlYPJiYU"]
        default:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login/"
        case .registration:
            return "/auth/registration/"
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
            return "/api/v1/courses/\(id)/"
        case .join:
            return "/api/v1/course/join/"
        }
    }
}
