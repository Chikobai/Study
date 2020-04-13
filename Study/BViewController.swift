//
//  ViewController.swift
//  ReadMoreTextView
//
//  Created by Ilya Puchka on 06.04.15.
//  Copyright (c) 2015 Ilya Puchka. All rights reserved.
//

import UIKit
import ReadMoreTextView

class BViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .red
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ReadMoreCell.self, forCellReuseIdentifier: ReadMoreCell.cellIdentifier())
    }

    override func viewDidLayoutSubviews() {
        tableView.reloadData()
    }

    var expandedCells = Set<Int>()

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReadMoreCell.cellIdentifier(), for: indexPath) as? ReadMoreCell
        cell?.backgroundColor = .yellow
        cell?.readMoreTextView.text = "Hi @lgor, I'm having the same issue & trying to implement your solution. The issue i'm getting is estimatedHeightForRowAtIndexPath gets called prior to willDisplayCell, so cell's height is not calculated when estimatedHeightForRowAtIndexPath is called. Any Help? – Madhuri Jul 25 '17 at 9:15@Madhuri effective heights should be calculated in heightForRowAtIndexPath, that is called for every cell on the screen just before willDisplayCell, which will set the height in the dictionary for later use in estimatedRowHeight (on table reload). – Donnit Jul 26 '17 at 15:16 "
        cell?.readMoreTextView.shouldTrim = !expandedCells.contains(indexPath.row)
        cell?.readMoreTextView.setNeedsUpdateTrim()
        cell?.readMoreTextView.layoutIfNeeded()
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ReadMoreCell {
            cell.readMoreTextView.onSizeChange = { [unowned tableView, unowned self] r in
                let point = tableView.convert(r.bounds.origin, from: r)
                guard let indexPath = tableView.indexPathForRow(at: point) else { return }
                if r.shouldTrim {
                    self.expandedCells.remove(indexPath.row)
                } else {
                    self.expandedCells.insert(indexPath.row)
                }
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ReadMoreCell {
            cell.readMoreTextView.shouldTrim = !cell.readMoreTextView.shouldTrim
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  100
    }
}

class ReadMoreCell : UITableViewCell {

    var readMoreTextView: ReadMoreTextView = ReadMoreTextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        readMoreTextView.backgroundColor = .cyan
        addSubview(readMoreTextView)
        readMoreTextView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        readMoreTextView.onSizeChange = { _ in }
        readMoreTextView.shouldTrim = true
    }
    
}
