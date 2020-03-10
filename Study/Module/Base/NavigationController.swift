//
//  NavigationController.swift
//  Meditatio kz
//
//  Created by Nazhmeddin Babakhanov on 21/10/2019.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {

    var isCaptured: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        view.backgroundColor = AppColor.white.uiColor
        setupScreenCapturedNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    deinit {
        print("DEINIT: NavigationController")
    }
}

private extension NavigationController {

    func setupScreenCapturedNotification() -> Void {

        NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: OperationQueue.main) { notification in

            if let viewController = self.viewControllers.last {
                if (self.isCaptured == false) {
//                    let lockViewController = LockViewController()
//                    viewController.present(lockViewController, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
                self.isCaptured.toggle()
            }
        }
    }
}

extension NavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController != self.viewControllers.first {
//            let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(popViewController(animated:)) )
//            viewController.navigationItem.leftBarButtonItem = backButton
        }
    }
}

extension NavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
