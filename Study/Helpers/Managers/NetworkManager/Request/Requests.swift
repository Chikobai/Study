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
        complitionHandler: @escaping (([Post])->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        let endpoints = Endpoints.posts(limit: 1, offset: 0)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                complitionHandlerError("")
            }
        }
    }

    func loadMorePosts(
        complitionHandler: @escaping (([Post])->Void),
        complitionHandlerError: @escaping ((String)->Void)
        ) -> Void {
        let endpoints = Endpoints.posts(limit: 1, offset: 0)
        networkManager.makeRequest(endpoint: endpoints) {(result: Result<GeneralPaginationModel<Post>>) in
            switch result {
            case .failure(let error, _):
                complitionHandlerError(error)
            case .success(let posts):
                complitionHandlerError("")
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
                guard (subscribedCourses.results.isEmpty == true) else {
                    complitionHandler(subscribedCourses.results)
                    return
                }
                complitionHandlerError("")
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
