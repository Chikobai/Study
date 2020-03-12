//
//  EditViewController.swift
//  Study
//
//  Created by I on 3/12/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

protocol EditDelegate: class {

    func didPressed(with type: EditItem) -> Void
    func didTyped(with key: String, _ typedText: String?, _ id: Int?)
}

class EditViewController: UITableViewController {

    private(set) var adapter: EditAdapter?
    private var validator: ContextEditValidator?

    init(with type: EditSection) {
        adapter = EditAdapter.init(with: type)
        validator = ContextEditValidator(with: type)
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = type.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: EditViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - EditDelegate

extension EditViewController: EditDelegate {

    func didPressed(with type: EditItem) -> Void {

    }

    func didTyped(with key: String, _ typedText: String?, _ id: Int?) -> Void {

        validator?.setParameter(key: key, value: typedText, id: id)
    }
}

// MARK: - Requests

private extension EditViewController {

}

// MARK: - Builds

private extension EditViewController {

    func build() -> Void {

        buildViews()
        buildServices()
    }

    func buildViews() -> Void {

        //superview
        view.backgroundColor = .white

        //table view
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        tableView.separatorStyle = .none

        //navigation controller
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }

    func buildServices() -> Void {

        adapter?.delegate = self
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.cellIdentifier())
        tableView.register(FloatingTextFieldItem.self, forCellReuseIdentifier: FloatingTextFieldItem.cellIdentifier())
        tableView.register(FilledButtonItem.self, forCellReuseIdentifier: FilledButtonItem.cellIdentifier())
        tableView.register(DefaultButtonItem.self, forCellReuseIdentifier: DefaultButtonItem.cellIdentifier())
        tableView.register(OTPItem.self, forCellReuseIdentifier: OTPItem.cellIdentifier())
        tableView.register(MessageItem.self, forCellReuseIdentifier: MessageItem.cellIdentifier())
    }
}


