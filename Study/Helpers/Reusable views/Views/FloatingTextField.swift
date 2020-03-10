//
//  FloatingTextField.swift
//  Study
//
//  Created by I on 2/18/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import InputMask


class FloatingTextField: UIView, MaskedTextFieldDelegateListener {

    // MARK: - Public

    var didTyped: ((String?)->())?
    
    var placeholder: String? {
        set {
            placeholderLabel.text = newValue
            titleLabel.text = newValue
        }
        get {
            return placeholderLabel.text
        }
    }

    var text: String {
        set {
            if maskString == "[...]" {
                textField.text = newValue
                return
            }
            maskConfiguration.put(text: newValue, into: textField, autocomplete: true)
        }
        get {
            if maskString == "[...]" {
                return textField.text ?? ""
            }

            return valueWithoutMask
        }
    }

    var keyboardType: UIKeyboardType {
        set {
            textField.keyboardType = newValue
        }
        get {
            return textField.keyboardType
        }
    }

    var isSecureTextEntry: Bool {
        set {
            textField.isSecureTextEntry = newValue
        }
        get {
            return textField.isSecureTextEntry
        }
    }

    var rightViewMode: UITextField.ViewMode {
        set {
            textField.rightViewMode = newValue
        }
        get {
            return textField.rightViewMode
        }
    }

    var rightView: UIView? {
        set {
            textField.rightView = newValue
        }
        get {
            return textField.rightView
        }
    }

    var maskString: String {
        set {
            
            maskConfiguration.primaryMaskFormat = newValue
            textField.delegate = maskConfiguration
        }
        get {
            return maskConfiguration.primaryMaskFormat
        }
    }

    func clear() {
        textField.text = ""
        textField.resignFirstResponder()
        didBecome(.inactive)
    }

    // MARK: - Private

    private let maskConfiguration = MaskedTextFieldDelegate()
    private var valueWithoutMask: String = ""

    private let textField = SecureTextField()
    private let titleLabel = UILabel()
    private let placeholderLabel = UILabel()

    private enum State {
        case active
        case inactive
    }

    init() {
        super.init(frame: .zero)
        build()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("DEINIT: FloatingTextField")
    }

    private func didBecome(_ state: State) {
        UIView.animate(withDuration: 0.1) {
            switch state {
            case .active:
                self.titleLabel.alpha = 1
                self.placeholderLabel.alpha = 0
            case .inactive:
                let isTextFieldEmpty = self.textField.text?.isEmpty == true
                self.titleLabel.alpha = isTextFieldEmpty ? 0 : 1
                self.placeholderLabel.alpha = isTextFieldEmpty ? 1 : 0
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension FloatingTextField: UITextFieldDelegate {

    func textField(_: UITextField, didFillMandatoryCharacters _: Bool, didExtractValue value: String) {
        valueWithoutMask = value
        didTyped?(value)

    }

    func textFieldDidBeginEditing(_: UITextField) {
        didBecome(.active)
    }

    func textFieldDidEndEditing(_: UITextField) {
        didBecome(.inactive)
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

// MARK: - Actions

private extension FloatingTextField {

    @objc
    func startEditing() {
        textField.becomeFirstResponder()
    }

    @objc
    func textInputTyped(_ sender: UITextField) {

        didTyped?(textField.text)
    }
}

// MARK: - Builds

private extension FloatingTextField {

    func build() -> Void {

        buildViews()
        buildLayouts()
        buildServices()
        buildGestures()
        buildTargets()
    }

    func buildViews() -> Void {

        //superview
        backgroundColor = AppColor.lightGray.uiColor
        layer.cornerRadius = 8

        //mask configuration
        maskString = "[...]"
        maskConfiguration.affinityCalculationStrategy = .prefix

        //placeholder label view
        placeholderLabel.textColor = UIColor.lightGray

        //title label view
        titleLabel.textColor = UIColor.lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.alpha = 0

        //text field view
        textField.tintColor = UIColor.darkGray
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none

    }

    func buildLayouts() -> Void {

        var layoutConstraints = [NSLayoutConstraint]()

        addSubview(placeholderLabel)
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ]

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            textField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    func buildServices() -> Void {

        textField.delegate = self
        maskConfiguration.listener = self
    }

    func buildGestures() -> Void {

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startEditing))
        addGestureRecognizer(tapGestureRecognizer)
    }

    func buildTargets() -> Void {

        textField.addTarget(self, action: #selector(textInputTyped), for: .editingChanged)
    }
}
