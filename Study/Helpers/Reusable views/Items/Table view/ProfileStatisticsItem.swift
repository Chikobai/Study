//
//  ProfileStatisticsItem.swift
//  Study
//
//  Created by I on 3/7/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

class ProfileStatisticsItem: UITableViewCell {

    private lazy var barChartView: BasicBarChart = BasicBarChart(frame: .zero)
    private lazy var titleLabelView: UILabel = UILabel()
    private lazy var timeLabelView: UILabel = UILabel()
    private lazy var timeValueLabelView: UILabel = UILabel()
    private lazy var efficiencyLabelView: UILabel = UILabel()
    private lazy var efficiencyValueLabelView: UILabel = UILabel()

    private let verticalPaddingValue: CGFloat = 6.0
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
        backgroundColor = .clear
        contentView.backgroundColor = AppColor.white.uiColor

        //title label view
        titleLabelView.text = AppTitle.Profile.statistics
        titleLabelView.textColor = AppColor.black.uiColor
        titleLabelView.font = .boldSystemFont(ofSize: 14.byWidth())
        titleLabelView.textAlignment = .left

        //time label view
        timeLabelView.text = "Time"
        timeLabelView.font = .systemFont(ofSize: 12.byWidth())
        timeLabelView.textColor = AppColor.darkGray.uiColor

        //time value label view
        timeValueLabelView.text = "14h 21m"
        timeValueLabelView.font = .systemFont(ofSize: 20.byWidth())
        timeValueLabelView.textColor = AppColor.main.uiColor

        //efficiency label view
        efficiencyLabelView.text = "Efficiency"
        efficiencyLabelView.font = .systemFont(ofSize: 12.byWidth())
        efficiencyLabelView.textColor = AppColor.darkGray.uiColor

        //efficiency value label view
        efficiencyValueLabelView.text = "2h 16m"
        efficiencyValueLabelView.font = .systemFont(ofSize: 20.byWidth())
        efficiencyValueLabelView.textColor = AppColor.main.uiColor

        //bar chart view
        let dataEntries = generateRandomDataEntries()
        barChartView.updateDataEntries(dataEntries: dataEntries, animated: true)

    }

    func buildLayouts() -> Void {

        addSubviews(with: [titleLabelView, timeLabelView, timeValueLabelView, efficiencyLabelView, efficiencyValueLabelView, barChartView])

        titleLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(45.byWidth())
            make.top.equalTo(12.byWidth() + verticalPaddingValue)
        }

        timeLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabelView.snp.bottom).offset(15.byWidth())
            make.left.equalTo(titleLabelView)
        }

        timeValueLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabelView.snp.bottom).offset(5.byWidth())
            make.left.equalTo(timeLabelView)
        }

        efficiencyLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(timeValueLabelView.snp.bottom).offset(15.byWidth())
            make.left.equalTo(timeValueLabelView)
        }

        efficiencyValueLabelView.snp.makeConstraints { (make) in
            make.top.equalTo(efficiencyLabelView.snp.bottom).offset(5.byWidth())
            make.left.equalTo(efficiencyLabelView)
        }

        barChartView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalTo(140.byWidth())
            make.height.equalTo(140.byWidth())
            make.bottom.equalTo(-10.byWidth() - verticalPaddingValue)
            make.top.equalTo(12.byWidth() + verticalPaddingValue)
        }
    }

    func buildFrames() -> Void {

        let contentViewFrame = self.contentView.frame
        let insetContentViewFrame = contentViewFrame.inset(by: UIEdgeInsets(top: verticalPaddingValue, left: 0, bottom: verticalPaddingValue, right: 0))
        self.contentView.frame = insetContentViewFrame
        self.selectedBackgroundView?.frame = insetContentViewFrame
    }
}
