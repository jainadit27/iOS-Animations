//
//  SearchViewController.swift
//  Animations
//
//  Created by Aditya Jain on 9/13/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {
    
    //Metrics
    let sidePadding : CGFloat = 24
    let verticalPadding : CGFloat = 24
    
    let textFieldHeight : CGFloat = 48
    var textFieldWidth : CGFloat = 0
    let textFieldBorderWidth : CGFloat = 3

    let buttonHeight : CGFloat = 48
    var buttonWidth : CGFloat = 0
    
    //Animation
    let strokeAnimationDuration = 0.75
    let cursorAnimationDuration = 0.3
    
    //Colors
    let purpleColor : UIColor = UIColor.init(hex: 0x4f108d)
    let pinkColor : UIColor = UIColor.init(hex: 0xfb3d65)
    
    let container : UIView = UIView.init()
    var textField : SearchField?
    
    let animateButton : PebbleButton = PebbleButton.init(type: .custom)
    let resetButton : PebbleButton = PebbleButton.init(type: .custom)
    
    var cursorLayer = CAShapeLayer()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        textField = SearchField.init(cursorWidth: textFieldBorderWidth, cursorHeight: textFieldHeight/2, cursorYOffset :2)
        textFieldWidth = UIScreen.main.bounds.width - 2*sidePadding
        buttonWidth = (UIScreen.main.bounds.width - 5*sidePadding)/2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = purpleColor
        var topPadding : CGFloat = 0
        if let navVC = self.navigationController{
            topPadding = topPadding + navVC.navigationBar.bounds.height
        }
        container.frame = CGRect.init(x: sidePadding, y: topPadding + 3*verticalPadding, width: textFieldWidth, height: textFieldHeight)
        view.addSubview(container)
        
        let roundedPath = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: textFieldWidth, height: textFieldHeight)), cornerRadius: textFieldHeight/2)
        
        let roundedLayer = CAShapeLayer()
        roundedLayer.path = roundedPath.cgPath
        roundedLayer.lineWidth = textFieldBorderWidth
        roundedLayer.strokeColor = pinkColor.cgColor
        roundedLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(roundedLayer)

        textField?.text = "SEARCH"
        textField?.textColor = pinkColor
        textField?.font = UIFont.boldSystemFont(ofSize: 14)
        textField?.frame = container.frame
        textField?.textAlignment = .center
        textField?.isUserInteractionEnabled = false
        textField?.tintColor = pinkColor //For cursor color
        textField?.autocapitalizationType = .allCharacters
        view.addSubview(textField!)
        
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(purpleColor, for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        resetButton.addTarget(self, action: #selector(self.doReset), for: .touchUpInside)
        resetButton.frame = CGRect.init(x: 2*sidePadding, y: container.frame.origin.y + container.frame.size.height + 2*verticalPadding, width: buttonWidth, height: buttonHeight)
        view.addSubview(resetButton)
        resetButton.setUpButton(buttonWidth: buttonWidth, buttonHeight: buttonHeight)
        
        animateButton.setTitle("ANIMATE", for: .normal)
        animateButton.setTitleColor(purpleColor, for: .normal)
        animateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        animateButton.addTarget(self, action: #selector(self.doAnimate), for: .touchUpInside)
        animateButton.frame = CGRect.init(x: UIScreen.main.bounds.width - 2*sidePadding - buttonWidth, y: resetButton.frame.origin.y, width: buttonWidth, height: buttonHeight)
        view.addSubview(animateButton)
        animateButton.setUpButton(buttonWidth: buttonWidth, buttonHeight: buttonHeight)
    }
    
    @objc private func doReset() {
        cursorLayer.removeFromSuperlayer()
        textField?.resignFirstResponder()
        textField?.isUserInteractionEnabled = false
        textField?.text = "SEARCH"
        textField?.alpha = 0
        textField?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        animateReversePath()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.textField?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.textField?.alpha = 1
        }, completion: nil)
    }
    
    @objc private func doAnimate() {
        animatePath()
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.textField?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            self.textField?.alpha = 0
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.textField?.isUserInteractionEnabled = true
            self.textField?.text = nil
            self.textField?.alpha = 1
            self.textField?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.textField?.becomeFirstResponder()
        }
    }
    
    func animatePath(){
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint.init(x: textFieldWidth/2, y: textFieldHeight))
        leftPath.addLine(to: CGPoint.init(x: textFieldWidth/6, y: textFieldHeight))
        leftPath.addArc(withCenter: CGPoint.init(x: textFieldHeight/2, y: textFieldHeight/2), radius: textFieldHeight/2, startAngle: .pi/2, endAngle: -.pi/2, clockwise: true)
        leftPath.addLine(to: CGPoint.init(x: textFieldWidth/2, y: 0))
        
        let forwardLeftLayer = CAShapeLayer()
        forwardLeftLayer.path = leftPath.cgPath
        forwardLeftLayer.strokeEnd = 0
        forwardLeftLayer.lineWidth = (textFieldBorderWidth + 1)
        forwardLeftLayer.strokeColor = purpleColor.cgColor
        forwardLeftLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(forwardLeftLayer)
        
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint.init(x: textFieldWidth/2, y: textFieldHeight))
        rightPath.addLine(to: CGPoint.init(x: 5*textFieldWidth/6, y: textFieldHeight))
        rightPath.addArc(withCenter: CGPoint.init(x: textFieldWidth - textFieldHeight/2, y: textFieldHeight/2), radius: textFieldHeight/2, startAngle: .pi/2, endAngle: -.pi/2, clockwise: false)
        rightPath.addLine(to: CGPoint.init(x: textFieldWidth/2, y: 0))
        
        let forwardRightLayer = CAShapeLayer()
        forwardRightLayer.path = rightPath.cgPath
        forwardRightLayer.strokeEnd = 0
        forwardRightLayer.lineWidth = (textFieldBorderWidth + 1)
        forwardRightLayer.strokeColor = purpleColor.cgColor
        forwardRightLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(forwardRightLayer)
        
        let middlePath = UIBezierPath()
        middlePath.move(to: CGPoint.init(x: textFieldWidth/2, y: textFieldHeight/4))
        middlePath.addLine(to: CGPoint.init(x: textFieldWidth/2, y: 3*textFieldHeight/4))
        
        cursorLayer.path = middlePath.cgPath
        cursorLayer.strokeEnd = 0
        cursorLayer.lineWidth = textFieldBorderWidth
        cursorLayer.strokeColor = pinkColor.cgColor
        cursorLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(cursorLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = 1
        animation.duration = strokeAnimationDuration
        animation.autoreverses = false
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        let cursorAnimation = CABasicAnimation(keyPath: "strokeEnd")
        cursorAnimation.toValue = 1
        cursorAnimation.beginTime = CACurrentMediaTime() + strokeAnimationDuration - 0.1
        cursorAnimation.duration = cursorAnimationDuration
        cursorAnimation.autoreverses = false
        cursorAnimation.repeatCount = 1
        cursorAnimation.fillMode = kCAFillModeForwards
        cursorAnimation.isRemovedOnCompletion = false
        
        let blinkAnimation = CABasicAnimation(keyPath: "opacity")
        blinkAnimation.fromValue = 1
        blinkAnimation.toValue = 0
        blinkAnimation.beginTime = CACurrentMediaTime() + strokeAnimationDuration + cursorAnimationDuration
        blinkAnimation.duration = 0.1
        blinkAnimation.autoreverses = false
        blinkAnimation.repeatCount = 1
        blinkAnimation.fillMode = kCAFillModeForwards
        blinkAnimation.isRemovedOnCompletion = false

        forwardLeftLayer.add(animation, forKey: "forwardLeftAnimation")
        forwardRightLayer.add(animation, forKey: "forwardRightAnimation")
        cursorLayer.add(cursorAnimation, forKey: "cursorAnimation")
        cursorLayer.add(blinkAnimation, forKey: "blinkAnimation")
    }
    
    func animateReversePath(){
        let leftPath = UIBezierPath()
        leftPath.move(to: CGPoint.init(x: textFieldWidth/2, y: textFieldHeight))
        leftPath.addLine(to: CGPoint.init(x: textFieldWidth/6, y: textFieldHeight))
        leftPath.addArc(withCenter: CGPoint.init(x: textFieldHeight/2, y: textFieldHeight/2), radius: textFieldHeight/2, startAngle: .pi/2, endAngle: -.pi/2, clockwise: true)
        leftPath.addLine(to: CGPoint.init(x: textFieldWidth/2, y: 0))
        
        let reverseLeftLayer = CAShapeLayer()
        reverseLeftLayer.path = leftPath.cgPath
        reverseLeftLayer.strokeEnd = 0
        reverseLeftLayer.lineWidth = textFieldBorderWidth
        reverseLeftLayer.strokeColor = pinkColor.cgColor
        reverseLeftLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(reverseLeftLayer)
        
        let rightPath = UIBezierPath()
        rightPath.move(to: CGPoint.init(x: textFieldWidth/2, y: textFieldHeight))
        rightPath.addLine(to: CGPoint.init(x: 5*textFieldWidth/6, y: textFieldHeight))
        rightPath.addArc(withCenter: CGPoint.init(x: textFieldWidth - textFieldHeight/2, y: textFieldHeight/2), radius: textFieldHeight/2, startAngle: .pi/2, endAngle: -.pi/2, clockwise: false)
        rightPath.addLine(to: CGPoint.init(x: textFieldWidth/2, y: 0))
        
        let reverseRightLayer = CAShapeLayer()
        reverseRightLayer.path = rightPath.cgPath
        reverseRightLayer.strokeEnd = 0
        reverseRightLayer.lineWidth = textFieldBorderWidth
        reverseRightLayer.strokeColor = pinkColor.cgColor
        reverseRightLayer.fillColor = UIColor.clear.cgColor
        container.layer.addSublayer(reverseRightLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.toValue = 1
        animation.duration = strokeAnimationDuration
        animation.autoreverses = false
        animation.repeatCount = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        reverseLeftLayer.add(animation, forKey: "reverseLeftAnimation")
        reverseRightLayer.add(animation, forKey: "reverseRightAnimation")
        
    }

}

