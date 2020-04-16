//
//  SearchDrawlable.swift
//  Study
//
//  Created by I on 4/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

protocol SearchDrawlable {}

extension SearchDrawlable where Self: CategoryViewController {

    func build() -> Void {

        buildViews()
    }

    func buildViews() -> Void {
        
        // view pager
        viewPager = ViewPager(containerView: self.view)

        //navigation item
        navigationItem.title = AppTitle.Category.title
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .search, target: self, action: #selector(searchPressed))

        //navigation bar
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
