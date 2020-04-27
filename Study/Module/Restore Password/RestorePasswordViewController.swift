//
//  RestorePasswordViewController.swift
//  Study
//
//  Created by I on 2/19/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol RestorePasswordDelegate: class {

    func didPressed(with type: RestorePasswordItem) -> Void
    func didTyped(with key: String, _ typedText: String?, _ id: Int?)
}

class RestorePasswordViewController: UITableViewController, Stylizing {

    private(set) var adapter: RestorePasswordAdapter?
    private var validator: ContextRestorePasswordValidator?

    init(with type: RestorePasswordSection) {
        adapter = RestorePasswordAdapter.init(with: type)
        validator = ContextRestorePasswordValidator(with: type)
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = type.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: RestorePasswordViewController")
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

// MARK: - RestorePasswordDelegate

extension RestorePasswordViewController: RestorePasswordDelegate {

    func didPressed(with type: RestorePasswordItem) -> Void {
        switch type {
        case .restoreEmailButton:
            restoreEmail()
        case .restorePasswordButton:
            restorePassword()
        case .changePasswordButton:
            changePassword()
        default:
            return
        }
    }

    func didTyped(with key: String, _ typedText: String?, _ id: Int?) -> Void {

        validator?.setParameter(key: key, value: typedText, id: id)
    }
}

// MARK: - Requests

private extension RestorePasswordViewController {

    func changePassword() -> Void {
        validator?.executeValidation(complitionOfSuccess: { [weak self] (params) in
            self?.adapter?.startLoading()
            Request.shared.changePassword(with: params, complitionHandler: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: {
                    self?.changeRootToAuthorization()
                })
            }, complitionHandlerError: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: nil)
            })
        }, complitionOfError: { [weak self] (message) in
            self?.display(with: message, completionHandler: nil)
        })
    }

    func restorePassword() -> Void {
        validator?.executeValidation(complitionOfSuccess: { [weak self] (params) in
            self?.adapter?.startLoading()
            Request.shared.restorePassword(with: params, complitionHandler: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }, complitionHandlerError: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: nil)
            })
        }, complitionOfError: { [weak self] (message) in
                self?.display(with: message, completionHandler: nil)
        })
    }

    func restoreEmail() -> Void {
        validator?.executeValidation(complitionOfSuccess: { [weak self] (params) in
            self?.adapter?.startLoading()
            Request.shared.restoreEmail(with: params, complitionHandler: { (message) in
                self?.adapter?.stopLoading()
                self?.display(with: message, completionHandler: {
                    self?.changeRootToAuthorization()
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

