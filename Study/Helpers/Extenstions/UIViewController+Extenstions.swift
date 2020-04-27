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
        alertController.addAction(UIAlertAction(title: "Oк", style: .default, handler: nil))

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func display(with message: String, completionHandler: (() -> ())?) -> Void {

        let alertController = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.view.tintColor = AppColor.main.uiColor
        alertController.addAction(UIAlertAction.init(title: "Ок", style: .default, handler: { (_) in
            completionHandler?()
        }))

        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension UIViewController {

    func changeRootToAuthorization() -> Void {
        let viewController = AuthorizationViewController(with: .loginWithEmail).inNavigate()
        if let window = UIApplication.shared.keyWindow {
            let options: UIView.AnimationOptions = .transitionFlipFromLeft
            let duration: TimeInterval = 1
            window.rootViewController = viewController
            UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: { (_) in
                StoreManager.shared().setToken(with: nil)
            })
        }
    }
}
