//
//  CustomError.swift
//  BKKZ
//
//  Created by Yerassyl Zhassuzakhov on 1/7/19.
//  Copyright © 2019 Nursultan. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case informationalError
    case redirectionError
    case notFoundError
    case serverError
    case unknownError
    case userBlocked
    case codeDoesntSend
    case codeDoesntAvailable
    case confirmPhoneVerification
    case codeIsNotCorrect
    case passwordIsNotCorrect
    case userAlreadyRegistered
    case userNotFound
    case promocodeNotFound
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .informationalError:
            return "Qate aqparat"
        case .redirectionError:
            return "Qaıta baǵyttalǵan"
        case .notFoundError:
            return "Tabylmady"
        case .serverError:
            return "Ishkі serverlіk qatelіk "
        case .codeDoesntAvailable:
            return "Kod engіzý ýaqyty ótіp kettі, qaıta jіberіńіz"
        case .codeDoesntSend:
            return "Habarlama jіberńlmedі"
        case .codeIsNotCorrect:
            return "Kod durys emes"
        case .passwordIsNotCorrect:
            return "Qupııa sóz durys emes"
        case .confirmPhoneVerification:
            return "Aldymen nomer engіzіńіz "
        case .userBlocked:
            return "Qoldanýshy qulyptandy "
        case .userAlreadyRegistered:
            return "Qoldanýshy tіrkelіngen, nomer qoldanylǵan"
        case .userNotFound:
            return "Bul aqparatqa sáıkes qoldanýshy tabylmady"
        case .promocodeNotFound:
            return "Promokod tabylmady"
        default:
            return "Anyqtalmaǵan qatelіk"
        }
    }
}
