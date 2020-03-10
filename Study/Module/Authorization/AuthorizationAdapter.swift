//
//  AuthorizationAdapter.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationAdapterDelegate: class {

}

class AuthorizationAdapter: NSObject {

    private var items: [AuthorizationSection] = []
    weak var delegate: AuthorizationDelegate?

    init(with type: AuthorizationSection) {
        items = [type]
        super.init()
    }

    deinit {
        print("DEINIT: AuthorizationAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension AuthorizationAdapter: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].cells.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = items[indexPath.section].cells[indexPath.row]
        switch type {
        case .passwordInput, .phoneInput, .nameInput, .emailInput:
            return self.floatingInputItemView(with: tableView, indexPath, type)
        case .loginButton, .resgistrationButton, .sendOTPButton:
            return self.filledButtonItemView(with: tableView, indexPath, type)
        case .toRestorePasswordButton, .toResgistrationButton, .toLoginButton:
            return self.defaultButtonItemView(with: tableView, indexPath, type)
        case .otpInput:
            return self.otpInputItemView(with: tableView, indexPath)
        case .OTPMessage, .loginMessage, .loginWithEmailMessage:
            return self.messageItemView(with: tableView, indexPath, type)
        case .emptySpacer:
            return self.emptyItemView(with: tableView, indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = items[indexPath.section].cells[indexPath.row]
        delegate?.didPressed(with: type)
    }
}


// MARK: - Custom Items

private extension AuthorizationAdapter {

    func filledButtonItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: AuthorizationItem
    ) -> FilledButtonItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: FilledButtonItem.cellIdentifier(), for: indexPath) as? FilledButtonItem
        cell?.configure(with: type.placeholder)
        cell?.buttonPressed = { [weak self] in
            self?.delegate?.didPressed(with: type)
        }
        return cell!
    }

    func defaultButtonItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: AuthorizationItem
    ) -> DefaultButtonItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultButtonItem.cellIdentifier(), for: indexPath) as? DefaultButtonItem
        cell?.configure(with: type.placeholder)
        cell?.buttonPressed = { [weak self] in
            self?.delegate?.didPressed(with: type)
        }
        return cell!
    }

    func floatingInputItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: AuthorizationItem
    ) -> FloatingTextFieldItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: FloatingTextFieldItem.cellIdentifier(), for: indexPath) as? FloatingTextFieldItem
        cell?.configure(with: type)
        cell?.didTyped = { [weak self] text in
            self?.delegate?.didTyped(with: type.key, text, nil)
        }
        return cell!
    }

    func otpInputItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath
        ) -> OTPItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: OTPItem.cellIdentifier(), for: indexPath) as? OTPItem
        return cell!
    }

    func messageItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: AuthorizationItem
        ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MessageItem.cellIdentifier(), for: indexPath) as? MessageItem
        cell?.configure(with: type.placeholder, (type == .OTPMessage) ? .center : .left)
        return cell!
    }

    func emptyItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.cellIdentifier(), for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}


