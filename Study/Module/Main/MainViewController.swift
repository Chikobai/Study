//
//  MainViewController.swift
//  Study
//
//  Created by I on 2/22/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, Stylizing {

    private(set) var adapter: MainAdapter = MainAdapter()

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    deinit {
        print("DEINIT: MainViewController")
    }
}
