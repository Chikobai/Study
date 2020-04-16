//
//  ViewPagerTab.swift
//  ViewPager-Swift
//
//  Created by Nishan on 1/9/17.
//  Copyright © 2017 Nishan. All rights reserved.
//

import Foundation
import UIKit

public enum ViewPagerTabType {

    /// Tab contains text only.
    case basic
    /// Tab contains images only.
    case image
}

public struct ViewPagerTab {
    
    public var title:String?
    public var image:UIImage?
    
    public init(title:String, image:UIImage? = nil) {
        self.title = title
        self.image = image
    }

    public init(title:String? = nil, image:UIImage) {
        self.title = title
        self.image = image
    }
}
