//
//  Parser.swift
//  BKKZ
//
//  Created by Yerassyl Zhassuzakhov on 1/7/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation
import Alamofire

public protocol Parser {
    func parse<T: Decodable>(response: DataResponse<Any>) -> Result<T>
}

public extension Parser {
    private func serializeStatusCode(_ statusCode: Int) -> String {
        var error: Error
        switch statusCode {
        case 100..<200:
            error = CustomError.informationalError
        case 300..<400:
            error = CustomError.redirectionError
        case 440:
            error = CustomError.codeDoesntSend
        case 441:
            error = CustomError.passwordIsNotCorrect
        case 442:
            error = CustomError.codeDoesntAvailable
        case 443:
            error = CustomError.confirmPhoneVerification
        case 444:
            error = CustomError.userBlocked
        case 445:
            error = CustomError.codeIsNotCorrect
        case 446:
            error = CustomError.userAlreadyRegistered
        case 447:
            error = CustomError.promocodeNotFound
        case 401:
            error = CustomError.userNotFound
        case 400..<500:
            error = CustomError.notFoundError
        case 500..<600:
            error = CustomError.serverError
        default:
            error = CustomError.unknownError
        }
        
        return error.localizedDescription
    }
    
    func parse<T: Decodable>(response: DataResponse<Any>) -> Result<T> {
        switch response.result {
        case .failure(let error):
            if let result = response.response?.statusCode {
                print(response.description)
                let message = serializeStatusCode(result)
                return Result.failure(message, result)
            } else {
                switch error._code {
                case NSURLErrorTimedOut, NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost:
                    return Result.failure("Подключитесь к сети", nil)
                default:
                    return Result.failure(error.localizedDescription, nil)
                }
            }
        case .success(_):
            if let result = response.result.value {
                if JSONSerialization.isValidJSONObject(result) {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: result, options: [])
                        let retrievingData = try JSONDecoder().decode(T.self, from: data)
                        
                        return Result.success(retrievingData)
                    } catch {
                        return Result.failure(error.localizedDescription, nil)
                    }
                } else {
                    return Result.failure("Result is not a valid JSON object", nil)
                }
            } else {
                return Result.failure("Ошибка при обработке данных!", nil)
            }
        }
    }
}
