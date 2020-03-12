//
//  UIViewController+Extenstions.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func inNavigate() -> NavigationController {
        
        return NavigationController(rootViewController: self)
    }

    func pushWithHidesBottomBar(_ directedController: UIViewController) -> Void {
        if let navigationController = self.navigationController {
            self.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(directedController, animated: true)
            self.hidesBottomBarWhenPushed=false
        }
    }

    func add(_ child: UIViewController, onView aView: UIView) {
        addChild(child)
        aView.addSubview(child.view)
        child.view.snp.makeConstraints { (make) in
            make.edges.equalTo(aView)
        }
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }

    func transparentBar() -> Void {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    func defaulteBar() -> Void {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
}
