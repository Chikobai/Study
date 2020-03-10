//
//  ScrollViewController.swift
//  gulmarket
//
//  Created by Eldor Makkambayev on 10/4/19.
//  Copyright © 2019 Yerassyl Zhassuzakhov. All rights reserved.
//

import Foundation
import UIKit
class ScrollViewController: UIViewController {
    
    //MARK: - Properties
    lazy var scrollView = UIScrollView()
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: - Start functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    //MARK: - Setup functions
    func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        view.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    //MARK: - functions
    func addToScrollView(_ views: [UIView]) -> Void {
        for view in views {
            scrollView.addSubview(view)
        }
    }
}
