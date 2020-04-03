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
    static let shared = Request()

    init() {
        
    }
}


//  MARK: GET REQUESTS
extension  Request {

    func loadPosts(
        complitionHandler: @escaping (([Post], Int)->Void),
        complitionHandlerError: @escaping ((String)->Void)
    ) -> Void {
        let endpoints = Endpoints.posts(limit: 3, offset: 0)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                guard (posts.results.isEmpty == false) else {
                    complitionHandlerError("No data")
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
        let endpoints = Endpoints.posts(limit: 3, offset: offset)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                complitionHandler(posts.results)
            }
        }
    }

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
                    complitionHandlerError("No data")
                    return
                }
                complitionHandler(subscribedCourses.results)
            }
        }
    }

    func loadCourses(
        complitionHandler: @escaping (([Course])->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        let endpoints = Endpoints.courses
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Course>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let courses):
                guard (courses.results.isEmpty == false) else {
                    complitionHandlerError("No data")
                    return
                }
                complitionHandler(courses.results)
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

    
}
