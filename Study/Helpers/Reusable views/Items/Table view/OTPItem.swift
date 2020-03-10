//
//  OTPItem.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import UIKit

enum Direction {
    case left, right
}

class OTPItem: UITableViewCell {

    var didPressed: (()->())?
    private var seconds = 10
    private var timer = Timer()

    private lazy var otpTextField1 = OTPTextField()
    private lazy var otpTextField2 = OTPTextField()
    private lazy var otpTextField3 = OTPTextField()
    private lazy var otpTextField4 = OTPTextField()
    private lazy var coverStackView = UIStackView()
    private lazy var timerMessageView: UILabel = UILabel()
    private lazy var resendButtonView: UIButton = UIButton.init(type: .system)


    private var verificationTextFieldsCollection: [OTPTextField] = []
    private var textFieldsIndexes:[UITextField:Int] = [:]
    private var verificationCode: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        verificationTextFieldsCollection = [otpTextField1, otpTextField2, otpTextField3, otpTextField4]
        for index in 0 ..< verificationTextFieldsCollection.count {
            textFieldsIndexes[verificationTextFieldsCollection[index]] = index
            verificationTextFieldsCollection[index].delegate = self
        }

        build()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: OTPItem")
    }

}

private extension OTPItem {

    func setNextResponder(_ index:Int?, direction:Direction) {

        guard let index = index else { return }

        if direction == .left {
            index == 0 ?
                (_ = verificationTextFieldsCollection.first?.resignFirstResponder()) :
                (_ = verificationTextFieldsCollection[(index - 1)].becomeFirstResponder())
        } else {
            index == verificationTextFieldsCollection.count - 1 ?
                (_ = verificationTextFieldsCollection.last?.resignFirstResponder()) :
                (_ = verificationTextFieldsCollection[(index + 1)].becomeFirstResponder())
        }

    }
}

extension OTPItem: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if range.length == 0 {
            textField.text = string
            setNextResponder(textFieldsIndexes[textField], direction: .right)
            return true
        } else if range.length == 1 {
            textField.text = ""
            setNextResponder(textFieldsIndexes[textField], direction: .left)
            return false
        }
        return false

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.verificationTextFieldsCollection[self.verificationTextFieldsCollection.count - 1]) {
            self.verificationCode = ""
            for singleField in verificationTextFieldsCollection {
                self.verificationCode += singleField.text!
            }
            print(self.verificationCode)
        }
    }
}

extension OTPItem {

    private func runTimer() {
        timerMessageView.text = AppTitle.Authorization.OTPTimer
        seconds = 10
        resendButtonView.isHidden = true
        timerMessageView.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc
    private  func updateTimer() {

        if (seconds < 1) {
            resendButtonView.isHidden = false
            timerMessageView.isHidden = true
            timer.invalidate()
        } else {
            seconds -= 1
            timerMessageView.text = "\(AppTitle.Authorization.OTPTimer) \(seconds) сек"
        }
    }

    @objc
    private func againSendCode() {
        timer.invalidate()
        runTimer()
        didPressed?()
    }
}

// MARK: - Builds

extension OTPItem {

    func build() -> Void {

        buildViews()
        buildLayout()
        runTimer()
    }

    func buildViews() -> Void {

        //superview
        selectionStyle = .none

        //stack view
        coverStackView.alignment = .fill
        coverStackView.distribution = .fillEqually
        coverStackView.axis = .horizontal
        coverStackView.spacing = 20

        //timer message view
        timerMessageView.font = UIFont.systemFont(ofSize: 14)
        timerMessageView.textColor = .lightGray
        timerMessageView.numberOfLines = 0
        timerMessageView.sizeToFit()
        timerMessageView.isHidden = true

        //resend button view
        resendButtonView.setTitle(AppTitle.Authorization.resendOTP, for: .normal)
        resendButtonView.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        resendButtonView.contentHorizontalAlignment = .left
        resendButtonView.setTitleColor(AppColor.main.uiColor, for: .normal)
        resendButtonView.addTarget(self, action: #selector(againSendCode), for: .touchUpInside)
        resendButtonView.isHidden = false
    }

    func buildLayout() -> Void {

        addSubviews(with: [coverStackView, timerMessageView, resendButtonView])
        coverStackView.addArrangedSubviews(with: [otpTextField1, otpTextField2, otpTextField3, otpTextField4])

        coverStackView.snp.makeConstraints { (make) in
            make.height.equalTo(55.0)
            make.left.equalTo(50.0)
            make.right.equalTo(-50.0)
            make.top.equalTo(10.0)
        }

        timerMessageView.snp.makeConstraints { (make) in
            make.top.equalTo(coverStackView.snp.bottom).offset(10)
            make.right.left.equalTo(coverStackView)
            make.bottom.equalTo(-10)
        }

        resendButtonView.snp.makeConstraints { (make) in
            make.edges.equalTo(timerMessageView)
        }
    }
}
