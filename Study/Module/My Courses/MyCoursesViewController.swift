//
//  TableViewController.swift
//  Study
//
//  Created by I on 2/26/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MyCoursesViewController: UITableViewController, Stylizing {

    private(set) var adapter: MyCoursesAdapter = MyCoursesAdapter()

    init(){
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    deinit {
        print("DEINIT: MyCoursesViewController")
    }
}

