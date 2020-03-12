//
//  EditAdapter.swift
//  Study
//
//  Created by I on 3/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class EditAdapter: NSObject {

    private var items: [EditSection] = []
    weak var delegate: EditDelegate?

    init(with type: EditSection) {
        items = [type]
        super.init()
    }

    deinit {
        print("DEINIT: EditAdapter")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension EditAdapter: UITableViewDelegate, UITableViewDataSource {

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
        case .phoneInput, .nameInput:
            return self.floatingInputItemView(with: tableView, indexPath, type)
        case .changeButton, .resumeButton:
            return self.filledButtonItemView(with: tableView, indexPath, type)
        case .nameMessageItem, .phoneMessageItem:
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

private extension EditAdapter {

    func filledButtonItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: EditItem
    ) -> FilledButtonItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: FilledButtonItem.cellIdentifier(), for: indexPath) as? FilledButtonItem
        cell?.configure(with: type.placeholder)
        cell?.buttonPressed = { [weak self] in
            self?.delegate?.didPressed(with: type)
        }
        return cell!
    }

    func floatingInputItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: EditItem
    ) -> FloatingTextFieldItem {

        let cell = tableView.dequeueReusableCell(withIdentifier: FloatingTextFieldItem.cellIdentifier(), for: indexPath) as? FloatingTextFieldItem
        cell?.configure(with: type)
        cell?.didTyped = { [weak self] text in
            self?.delegate?.didTyped(with: type.key, text, nil)
        }
        return cell!
    }


    func messageItemView(
        with tableView: UITableView,
        _ indexPath: IndexPath,
        _ type: EditItem
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MessageItem.cellIdentifier(), for: indexPath) as? MessageItem
        cell?.configure(with: type.placeholder, .left)
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


