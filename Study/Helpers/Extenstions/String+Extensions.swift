//
//  String+Extensions.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension String {

    var localized: String {
        if let languageCode = Locale.current.languageCode {
            let resource = (languageCode == "ru") ? "ru" : "kk-KZ"
            let path = Bundle.main.path(forResource: resource, ofType: "lproj")
            let bundle = Bundle(path: path!)
            return (bundle?.localizedString(forKey: self, value: nil, table: nil))!
        }
        return ""
    }
    

    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}
