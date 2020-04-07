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

    func display(with message: String) -> Void {

        let alertController = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.view.tintColor = AppColor.main.uiColor
        alertController.addAction(UIAlertAction.init(title: "Ок", style: .default, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
