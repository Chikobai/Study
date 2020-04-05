//
//  PrimaryComponentButton.swift
//  Chocolife
//
//  Created by Нуржан Орманали on 7/4/19.
//  Copyright © 2019 Chocolife.me. All rights reserved.
//

import UIKit

fileprivate let circleRadius: CGFloat = 15

class LoadingButton: UIButton {
    
    private var savedTitle: String? = nil
    private var savedCornerRadius: CGFloat = 0
    
    lazy var spinner: SpinnerView = {
        let spinner = SpinnerView()
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        NotificationCenter.default.addObserver(self, selector: #selector(startLoading), name: NSNotification.Name.init(.startLoading), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopLoading), name: NSNotification.Name.init(.stopLoading), object: nil)
        self.addSubviews(with: [spinner])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    @objc public func startLoading() {
        self.superview?.endEditing(true)
        self.superview?.layoutIfNeeded()
        
        spinner.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset((self.frame.height - (circleRadius * 2)) / 2)
            make.width.height.equalTo(circleRadius * 2)
            make.centerY.equalToSuperview()
        }
        
        spinner.animate()
        startAnimation()
    }
    
    public func disable() {
        backgroundColor = AppColor.main.uiColor
        setTitleColor(AppColor.white.uiColor.withAlphaComponent(0.5), for: .normal)
        isUserInteractionEnabled = false
    }
    
    public func enable() {
        backgroundColor = AppColor.main.uiColor
        setTitleColor(AppColor.white.uiColor, for: .normal)
        isUserInteractionEnabled = true
    }
    
    private func startAnimation() {

        self.isUserInteractionEnabled = false
        self.savedTitle = title(for: .normal)
        self.savedCornerRadius = layer.cornerRadius
        
        self.setTitle("",  for: .normal)
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.layer.cornerRadius = self.frame.height / 2
        }, completion: { completed -> Void in
            self.minimizeWidth()
            self.spinner.animate()
        })
    }
    
    private func minimizeWidth() {
        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.fromValue = frame.width
        widthAnimation.toValue = frame.height
        widthAnimation.duration = 0.1
        widthAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        widthAnimation.fillMode = .forwards
        widthAnimation.isRemovedOnCompletion = false
        
        layer.add(widthAnimation, forKey: widthAnimation.keyPath)
    }
    
    @objc public func stopLoading(completion: (() -> ())? = nil) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.setOriginalState(completion: completion)
        }
    }
    
    private func setOriginalState(completion: (() -> ())? = nil) {
        self.animateToOriginalWidth(completion: completion)
        self.spinner.stopAnimation()
        self.setTitle(self.savedTitle, for: .normal)
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = self.savedCornerRadius
    }
    
    private func animateToOriginalWidth(completion: (() -> ())? = nil) {
        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.fromValue = (self.bounds.height)
        widthAnimation.toValue = (self.bounds.width)
        widthAnimation.duration = 0.1
        widthAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        widthAnimation.fillMode = .forwards
        widthAnimation.isRemovedOnCompletion = false
        
        CATransaction.setCompletionBlock {
            completion?()
            self.layer.removeAllAnimations()
        }
        self.layer.add(widthAnimation, forKey: widthAnimation.keyPath)
        
        CATransaction.commit()
    }
    
}

class SpinnerView : UIView {
    
    let circlePathLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        circlePathLayer.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        circlePathLayer.path = circlePath().cgPath
    }
    
    func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 2
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = AppColor.white.uiColor.cgColor
        layer.addSublayer(circlePathLayer)
        backgroundColor = .clear
    }
    
    func circlePath() -> UIBezierPath {
        self.layoutIfNeeded()
        let startAngle = 0 - Double.pi/2
        let endAngle = Double.pi * 2 - Double.pi
        return UIBezierPath(arcCenter: CGPoint(x: circleRadius, y: circleRadius), radius: circleRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
    }
    
    func animate() {
        
        self.circlePathLayer.isHidden = false
        let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
        rotate.fromValue = 0
        rotate.toValue = Double.pi * 2
        rotate.duration = 0.4
        rotate.timingFunction = CAMediaTimingFunction(name: .linear)
        
        rotate.repeatCount = HUGE
        rotate.fillMode = .forwards
        rotate.isRemovedOnCompletion = false
        self.circlePathLayer.add(rotate, forKey: rotate.keyPath)
        
    }
    
    func stopAnimation() {
        
        self.circlePathLayer.removeAllAnimations()
        self.circlePathLayer.isHidden = true
        
    }
}
