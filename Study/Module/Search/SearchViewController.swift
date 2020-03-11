//
//  SearchViewController.swift
//  Study
//
//  Created by I on 2/24/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, Stylizing {

    private(set) var searchController: UISearchController = UISearchController.init(searchResultsController: nil)
    private var items: [String] = [
        "IBM Data Science", "Intoduction to Data Science", "Google IT Automation with Python", "Google IT Support", "Deep Learning", "Python for Everybody", "Machine Learning", "Applied Data Science", "IBM Aplied AI", "Business Foundations", "TensorFlow in Practice", "Big Data", "Crash course on Python", "Digital Marketing"
    ]
    private var filteredItems: [String] = []

    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        build()
    }

    deinit {
        print("DEINIT: SearchViewController")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredItems.count
        }
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PackageItem.cellIdentifier(), for: indexPath) as? PackageItem
        cell?.packageNameLabelView.text = (isFiltering == true) ? filteredItems[indexPath.row] : items[indexPath.row]

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CourseDetailsViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        let searchText = searchController.searchBar.text ?? ""
        filteredItems = items.filter { (item: String) -> Bool in
            return item.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }
}
