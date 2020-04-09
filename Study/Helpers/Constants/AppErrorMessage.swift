//
//  AppErrorMessage.swift
//  Study
//
//  Created by I on 4/5/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation

class AppErrorMessage {

    static let somethingIsWrong = "Что-то не так. Приносим извинения за неудобства"
    static let success = "Успешно ;)"
    static let noData = "К сожалению, данные пока отсутствуют"

    class Authorization {

        static let emailIsNotValid      = "Некорректный адрес электронной почты"
        static let passwordIsSoWeak     = "Поле пароля должно быть не меньше 8"
        static let nameIsEmpty          = "Поле имя не должно быть пустым"
        static let surnameIsEmpty       = "Поле фамилия не должно быть пустым"
        static let verification         = "Пожалуйста подтвердите вашу почту. Мы были уверены что это действительно ваша почта."
    }
}
