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
    case subscribedCourses(
        token: String
    )
    case lesson(
        token: String,
        moduleIdentifier: Int, lessonIdentifier: Int
    )
    case posts(
        token: String,
        limit: Int, offset: Int
    )
    case courses(
        token: String,
        categoryIdentifier: Int, limit: Int, offset: Int
    )
    case modules(
        token: String,
        courseIdentifier: Int, limit: Int, offset: Int
    )
    case reviews(
        token: String,
        courseIdentifier: Int, limit: Int, offset: Int
    )
    case info(
        token: String, courseIdentifier: Int
    )

    //POST

    case login(
        params: [String: String]
    )
    case profile(
        token: String
    )
    case registration(
        params: [String: String]
    )
    case join(
        token: String, courseIdentifier: Int
    )
    case sendComment(
        token: String, courseIdentifier: Int, params: [String:String]
    )

    case changePassword(
        token: String, params: [String: String]
    )
    case restorePassword(
        params: [String: String]
    )
    case restoreEmail(
        token: String, params: [String: String]
    )

    //PUT
    case update(
        token: String,
        params: [String: String]
    )

    case updateImage(
        token: String,
        image: Data
    )

    //DEL
    
    var baseURL: String {
        return "https://usernotfound.pythonanywhere.com"
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .join,
             .login,
             .profile,
             .registration,
             .changePassword,
             .restoreEmail,
             .restorePassword,
             .sendComment:
            return .post
        case .update, .updateImage:
            return .put
        default:
            return  .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .posts(_, let limit, let offset),
             .modules(_, _, let limit, let offset),
             .reviews(_, _, let limit, let offset):
            return .requestWithParameters(parameters: [
                "page": offset, "limit": limit
            ])
        case .courses(_, let categoryIdentifier, let limit, let offset):
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
        case .restorePassword(let params),
             .restoreEmail(_, let params),
             .changePassword(_, let params),
             .sendComment(_, _, let params):
            return .requestWithParameters(parameters: params)
        case .update(_, let params):
            return .requestWithParameters(parameters: params)
        case .updateImage(_, let image):
            return .requestWithMultipartData(data: image, parameters: [:], dataParameterName: "image")
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .subscribedCourses(let token),
             .profile(let token),
             .join(let token, _),
             .info(let token, _),
             .changePassword(let token, _),
             .restoreEmail(let token, _),
             .posts(let token, _, _),
             .lesson(let token, _, _),
             .sendComment(let token, _, _),
             .courses(let token, _, _, _),
             .modules(let token, _, _, _),
             .reviews(let token, _, _, _),
             .update(let token, _),
             .updateImage(let token, _):
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
        case .profile:
            return "/user/profile/"
        case .update, .updateImage:
            return "/user/update/"
        case .changePassword:
            return "/user/change-password/"
        case .restorePassword:
            return "/user/reset-password/"
        case .restoreEmail:
            return "/user/change-email/"
        case .posts:
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
        case .lesson(_, let moduleIdentifier, let lessonIdentifier):
            return "/api/v1/course/modules/\(moduleIdentifier)/lessons/\(lessonIdentifier)/"
        case .join:
            return "/api/v1/course/join/"
        case .sendComment(_, let courseIdentifier, _):
            return "/api/v1/course/\(courseIdentifier)/reviews/"
        case .categories:
            return "/api/v1/course/categories/"
        }
    }
}
