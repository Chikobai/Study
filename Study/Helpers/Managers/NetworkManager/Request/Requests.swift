//
//  Worker.swift
//  Kupizalog
//
//  Created by I on 11/6/19.
//  Copyright © 2019 Shyngys. All rights reserved.
//

import Foundation

class Request{

    private let networkManager: NetworkManager = NetworkManager()
    private let limit: Int = 10
    private let page: Int = 1
    static let shared = Request()

    init() {
        
    }
}


//  MARK: GET REQUESTS
extension  Request {

    //  MARK: POSTS

    func loadPosts(
        complitionHandler: @escaping (([Post], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.posts(
                token: token, limit: limit, offset: page
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let posts):
                    guard (posts.data.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(posts.data, posts.count)
                }
            }
        }
    }

    func loadMorePosts(
        offset: Int,
        complitionHandler: @escaping (([Post])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.posts(
                token: token, limit: limit, offset: page
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let posts):
                    complitionHandler(posts.data)
                }
            }
        }
    }

    //  MARK: SUBSCRIBED COURSES

    func loadSubscribedCourses(
        complitionHandler: @escaping (([Course])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.subscribedCourses(token: token)
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let subscribedCourses):
                    guard (subscribedCourses.data.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(subscribedCourses.data)
                }
            }
        }
    }

    //  MARK: COURSES

    func loadCourses(
        with categoryIdentifier: Int,
        complitionHandler: @escaping (([Course], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.courses(
                token: token, categoryIdentifier: categoryIdentifier, limit: limit,
                offset: page
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let courses):
                    guard (courses.data.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(courses.data, courses.count)
                }
            }
        }
    }

    func loadMoreCourses(
        with categoryIdentifier: Int,
        _ offset: Int,
        complitionHandler: @escaping (([Course])->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.courses(
                token: token, categoryIdentifier: categoryIdentifier, limit: limit,
                offset: offset
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let courses):
                    complitionHandler(courses.data)
                }
            }
        }
    }

    //  MARK: MODULES

    func loadModules(
        with courseIdentifier: Int,
        complitionHandler: @escaping (([Module], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.modules(
                token: token, courseIdentifier: courseIdentifier, limit: limit, offset: page
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Module>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let modules):
                    guard (modules.data.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(modules.data, modules.count)
                }
            }
        }
    }

    func loadMoreModules(
        with courseIdentifier: Int,
        offset: Int,
        complitionHandler: @escaping (([Module])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.modules(
                token: token, courseIdentifier: courseIdentifier, limit: limit, offset: offset
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Module>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let modules):
                    complitionHandler(modules.data)
                }
            }
        }
    }

    //  MARK: REVIEWS

    func loadReviews(
        with courseIdentifier: Int,
        complitionHandler: @escaping (([Review], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.reviews(
                token: token, courseIdentifier: courseIdentifier, limit: limit, offset: page
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Review>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let reviews):
                    guard (reviews.data.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(reviews.data, reviews.count)
                }
            }
        }
    }

    func loadMoreReviews(
        with courseIdentifier: Int,
        offset: Int,
        complitionHandler: @escaping (([Review])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.reviews(
                token: token, courseIdentifier: courseIdentifier, limit: limit, offset: offset
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Review>>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let reviews):
                    complitionHandler(reviews.data)
                }
            }
        }
    }

    //  MARK: INFO

    func loadInfo(
        with courseIdentifier: Int,
        complitionHandler: @escaping ((CourseInfo)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.info(
                token: token, courseIdentifier: courseIdentifier
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<CourseInfo>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let info):
                    complitionHandler(info)
                }
            }
        }
    }

    //  MARK: CATEGORIES

    func loadCategories(
        complitionHandler: @escaping (([Category])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.categories
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<[Category]>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let categories):
                complitionHandler(categories)
            }
        }
    }

    //  MARK: LESSON

    func loadLesson(
        with moduleIdentifier: Int,
        _ lessonIdentifier: Int,
        complitionHandler: @escaping (([LessonPage])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.lesson(
                token: token,
                moduleIdentifier: moduleIdentifier, lessonIdentifier: lessonIdentifier
            )
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<LessonPageResult>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let lesson):
                    guard (lesson.pages.isEmpty == false) else {
                        complitionHandlerError(AppErrorMessage.noData)
                        return
                    }
                    complitionHandler(lesson.pages)
                }
            }
        }
    }
}

//  MARK: PUT REQUESTS
extension Request {


}

//  MARK: DELETE
extension Request {

}

//  MARK: POST REQUESTS
extension Request {

    //  MARK: LOGIN

    func login(
        with params: [String: String],
        complitionHandler: @escaping (()->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {

        let endpoints = Endpoints.login(params: params)
        networkManager.makeRequest(endpoint: endpoints) { (result: Result<Auth>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let response):
                guard response.success == true else {
                    complitionHandlerError(response.message ?? AppErrorMessage.somethingIsWrong)
                    return
                }
                complitionHandler()
                StoreManager.shared().setToken(with: response.token)
            }
        }
    }

    //  MARK: REGISTRATION

    func registration(
        with params: [String: String],
        complitionHandler: @escaping (()->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {

        let endpoints = Endpoints.registration(params: params)
        networkManager.makeRequest(endpoint: endpoints) { (result: Result<Auth>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let response):
                guard response.success == true else {
                    complitionHandlerError(response.message ?? AppErrorMessage.somethingIsWrong)
                    return
                }
                complitionHandler()
            }
        }
    }

    //  MARK: JOIN TO COURSE

    func join(
        with courseIdentifier: Int,
        complitionHandler: @escaping ((String)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        if let token = StoreManager.shared().token() {
            let endpoints = Endpoints.join(token: token, courseIdentifier: courseIdentifier)
            networkManager.makeRequest(endpoint: endpoints) {(result: Result<Response>) in
                switch result {
                case .failure(let error, _):
                    complitionHandlerError(error)
                case .success(let response):
                    guard response.success == true else {
                        complitionHandlerError(response.message ?? AppErrorMessage.somethingIsWrong)
                        return
                    }
                    complitionHandler(response.message ?? AppErrorMessage.success)
                }
            }
        }
    }
}
