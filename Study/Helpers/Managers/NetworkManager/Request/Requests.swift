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
    private let limit: Int = 3
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
        let endpoints = Endpoints.posts(limit: limit, offset: page)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                guard (posts.results.isEmpty == false) else {
                    complitionHandlerError(AppErrorMessage.noData)
                    return
                }
                complitionHandler(posts.results, posts.count)
            }
        }
    }

    func loadMorePosts(
        offset: Int,
        complitionHandler: @escaping (([Post])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.posts(limit: limit, offset: offset)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                complitionHandler(posts.results)
            }
        }
    }

    //  MARK: SUBSCRIBED COURSES

    func loadSubscribedCourses(
        complitionHandler: @escaping (([SubscribedCourse])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.subscribedCourses
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<SubscribedCourse>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let subscribedCourses):
                guard (subscribedCourses.results.isEmpty == false) else {
                    complitionHandlerError(AppErrorMessage.noData)
                    return
                }
                complitionHandler(subscribedCourses.results)
            }
        }
    }

    //  MARK: COURSES

    func loadCourses(
        complitionHandler: @escaping (([Course], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        let endpoints = Endpoints.courses(limit: limit, offset: page)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let courses):
                guard (courses.results.isEmpty == false) else {
                    complitionHandlerError(AppErrorMessage.noData)
                    return
                }
                complitionHandler(courses.results, courses.count)
            }
        }
    }

    func loadMoreCourses(
        offset: Int,
        complitionHandler: @escaping (([Course])->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        let endpoints = Endpoints.courses(limit: limit, offset: offset)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let courses):
                complitionHandler(courses.results)
            }
        }
    }

    //  MARK: MODULES

    func loadModules(
        with id: Int,
        complitionHandler: @escaping (([Module], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.modules(id: id, limit: limit, offset: page)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Module>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let modules):
                guard (modules.results.isEmpty == false) else {
                    complitionHandlerError(AppErrorMessage.noData)
                    return
                }
                complitionHandler(modules.results, modules.count)
            }
        }
    }

    func loadMoreModules(
        with id: Int,
        offset: Int,
        complitionHandler: @escaping (([Module])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.modules(id: id, limit: limit, offset: offset)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Module>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let modules):
                complitionHandler(modules.results)
            }
        }
    }

    //  MARK: REVIEWS

    func loadReviews(
        with id: Int,
        complitionHandler: @escaping (([Review], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.reviews(id: id, limit: limit, offset: page)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Review>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let reviews):
                guard (reviews.results.isEmpty == false) else {
                    complitionHandlerError(AppErrorMessage.noData)
                    return
                }
                complitionHandler(reviews.results, reviews.count)
            }
        }
    }

    func loadMoreReviews(
        with id: Int,
        offset: Int,
        complitionHandler: @escaping (([Review])->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.reviews(id: id, limit: limit, offset: offset)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Review>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let reviews):
                complitionHandler(reviews.results)
            }
        }
    }

    //  MARK: INFO

    func loadInfo(
        with id: Int,
        complitionHandler: @escaping ((CourseInfo)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.info(id: id)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<CourseInfo>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let info):
                complitionHandler(info)
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
        with course_id: Int,
        complitionHandler: @escaping ((String)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.join(course_id: course_id)
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
