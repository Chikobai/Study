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

    case categories
    case posts(
        limit: Int, offset: Int
    )
    case subscribedCourses(
        token: String
    )
    case courses(
        token: String, limit: Int, offset: Int,
        categoryIdentifier: Int
    )
    case modules(
        token: String, courseIdentifier: Int,
        limit: Int, offset: Int
    )
    case reviews(
        token: String, courseIdentifier: Int,
        limit: Int, offset: Int
    )
    case info(
        token: String, courseIdentifier: Int
    )

    //POST

    case login(params: [String: String])
    case registration(params: [String: String])
    case join(token: String, courseIdentifier: Int)

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
             .modules(_, _, let limit, let offset),
             .reviews(_, _, let limit, let offset):
            return .requestWithParameters(parameters: [
                "page": offset, "limit": limit
            ])
        case .courses(_, let limit, let offset, let categoryIdentifier):
            return .requestWithParameters(parameters: [
                "page": offset, "limit": limit, "category_id": categoryIdentifier
            ])
        case .join(_ ,let courseIdentifier):
            return .requestWithParameters(parameters: [
                "course_id": courseIdentifier
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
        case .posts:
            return ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im9yeW5iYXNzYXIuc2h5bmd5c0BnbWFpbC5jb20iLCJpZCI6MTcsImlhdCI6MTU4NjQxMTYxNn0.OE0F6ZVNjrYbit8LERwv0Gkv3KZ8ECtS6puSlYPJiYU"]
        case .subscribedCourses(let token),
             .join(let token, _),
             .info(let token, _),
             .courses(let token, _, _, _),
             .modules(let token, _, _, _),
             .reviews(let token, _, _, _):
            return ["Authorization": "Bearer \(token)"]
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
        case .modules(_, let courseIdentifier, _, _):
            return "/api/v1/course/\(courseIdentifier)/modules/"
        case .reviews(_, let courseIdentifier, _, _):
            return "/api/v1/course/\(courseIdentifier)/reviews/"
        case .info(_, let courseIdentifier):
            return "/api/v1/courses/\(courseIdentifier)/"
        case .join:
            return "/api/v1/course/join/"
        case .categories:
            return "/api/v1/course/categories/"
        }
    }
}
