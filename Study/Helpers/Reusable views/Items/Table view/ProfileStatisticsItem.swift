//
//  ProfileStatisticsItem.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit
import Charts

class ProfileStatisticsItem: UITableViewCell {

    private lazy var barChartView: BasicBarChart = BasicBarChart(frame: .zero)
    private lazy var titleLabelView: UILabel = UILabel()
    private let verticalPaddingValue: CGFloat = 12.0
    private let numEntry = 7

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        buildFrames()
    }

    deinit {
        print("DEINIT: ProfileStatisticsItem")
    }
}

private extension ProfileStatisticsItem {

    func generateRandomDataEntries() -> [DataEntry] {
        var result: [DataEntry] = []
        for _ in 0..<numEntry {
            let value = (arc4random() % 90) + 10
            let height: Float = Float(value) / 100.0
            result.append(DataEntry(color: AppColor.main.uiColor, height: height, textValue: "", title: ""))
        }
        return result
    }
}

// MARK: - Builds

private extension ProfileStatisticsItem {

    func build() -> Void {

        buildViews()
        buildLayouts()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none
        backgroundColor = AppColor.lightGray.uiColor
        contentView.backgroundColor = AppColor.white.uiColor

        //title label view
        titleLabelView.text = AppTitle.Profile.statistics
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.font = .boldSystemFont(ofSize: 14)
        titleLabelView.textAlignment = .left

        //bar chart view
        let dataEntries = generateRandomDataEntries()
        barChartView.updateDataEntries(dataEntries: dataEntries, animated: true)

    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, barChartView])
        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(45)
            make.top.equalTo(12 + verticalPaddingValue)
        }
        barChartView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(140)
            make.height.equalTo(120)
            make.bottom.equalTo(-10)
            make.top.equalTo(12 + verticalPaddingValue)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: 0, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }
}
