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

    private lazy var barChartView: BarChartView = BarChartView()

    private var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"]
    private let verticalPaddingValue: CGFloat = 12.0

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

extension ProfileStatisticsItem {

    func setChart(dataPoints: [String], values: [Double]) {

        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: nil)
        chartDataSet.setColor(AppColor.main.uiColor)
        chartDataSet.highlightColor = AppColor.main.uiColor
        chartDataSet.drawValuesEnabled = false
    
        let chartData = BarChartData.init(dataSet: chartDataSet)
        barChartView.data = chartData
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

        //bar chart view
        barChartView.backgroundColor = AppColor.white.uiColor

        let leftAxisFormatter1 = NumberFormatter()
        leftAxisFormatter1.minimumFractionDigits = 0
        leftAxisFormatter1.maximumFractionDigits = 1

        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter1)
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = false
        xAxis.axisLineColor = .clear

        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1

        let leftAxis = barChartView.leftAxis
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.drawGridLinesEnabled = false
        leftAxis.granularityEnabled = false
        leftAxis.axisLineColor = .clear

        barChartView.rightAxis.enabled = false
        barChartView.legend.form = .line
        barChartView.legend.formLineWidth = 2
        barChartView.legend.formSize = 40
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false

        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0]
        setChart(dataPoints: months, values: unitsSold)
    }

    func buildLayouts() -> Void {

        addSubview(barChartView)
        barChartView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(100)
            make.height.equalTo(120)
            make.bottom.equalTo(-10)
            make.top.equalTo(10 + verticalPaddingValue)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: 0, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }
}
