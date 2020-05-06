//
//  AuthorizationViewController.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol AuthorizationDelegate: class {

    func didPressed(with type: AuthorizationItem) -> Void
    func didTyped(with key: String, _ typedText: String?, _ id: Int?)
}

class AuthorizationViewController: UITableViewController, Stylizing {

    private(set) var adapter: AuthorizationAdapter?
    private var validator: ContextAuthorizationValidator?

    init(with type: AuthorizationSection) {
        adapter = AuthorizationAdapter.init(with: type)
        validator = ContextAuthorizationValidator(with: type)
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = type.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: AuthorizationViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - AuthorizationDelegate

extension AuthorizationViewController: AuthorizationDelegate {

    func didPressed(with type: AuthorizationItem) -> Void {
        switch type {
        case .toResgistrationButton:
            let viewController = AuthorizationViewController(with: .registrationWithEmail)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .toLoginButton:
            self.navigationController?.popViewController(animated: true)
        case .toRestorePasswordButton:
            let viewController = RestoreViewController(with: .restorePassword)
            self.navigationController?.pushViewController(viewController, animated: true)
        case .loginButton:
            self.login()
        case .resgistrationButton:
            self.registration()
        default:
            return
        }
    }

    func didTyped(with key: String, _ typedText: String?, _ id: Int?) -> Void {

        validator?.setParameter(key: key, value: typedText, id: id)
    }
}

// MARK: - Requests

private extension AuthorizationViewController {

    func login() -> Void {

        let viewController = TabBarViewController()
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.modalPresentationStyle = .fullScreen
        validator?.executeValidation(complitionOfSuccess: { [weak self] (params) in
            self?.view.endEditing(true)
            self?.adapter?.startLoading()
            Request.shared.login(with: params, complitionHandler: {
                self?.adapter?.stopLoading()
                self?.present(viewController, animated: true, completion: nil)
            }, complitionHandlerError: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: nil)
            })
        }, complitionOfError: { [weak self] (message) in
            self?.display(with: message, completionHandler: nil)
        })
    }

    func registration() -> Void {

        validator?.executeValidation(complitionOfSuccess: { [weak self] (params) in
            self?.view.endEditing(true)
            self?.adapter?.startLoading()
            Request.shared.registration(with: params, complitionHandler: {
                self?.adapter?.stopLoading()
                self?.display(with: AppErrorMessage.Authorization.verification, completionHandler: {
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                })
            }, complitionHandlerError: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: nil)
            })
        }, complitionOfError: { [weak self] (message) in
            self?.display(with: message, completionHandler: nil)
        })
    }
}

