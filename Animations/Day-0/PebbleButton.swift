//
//  PebbleButton.swift
//  Animations
//
//  Created by Aditya Jain on 9/14/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class PebbleButton : UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }) { (isCompleted) in
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        }) { (isCompleted) in
            
        }
    }
    
    public func setUpButton(buttonWidth : CGFloat, buttonHeight : CGFloat){
        let buttonPath = UIBezierPath()
        buttonPath.move(to: CGPoint.init(x: 0, y: buttonHeight))
        buttonPath.addLine(to: CGPoint.init(x: buttonWidth - buttonHeight/2, y: buttonHeight))
        buttonPath.addArc(withCenter: CGPoint.init(x: buttonWidth - buttonHeight/2, y: buttonHeight/2), radius: buttonHeight/2, startAngle: .pi/2, endAngle: 0, clockwise: false)
        buttonPath.addLine(to: CGPoint.init(x: buttonWidth, y: 0))
        buttonPath.addLine(to: CGPoint.init(x: buttonHeight/2, y: 0))
        buttonPath.addArc(withCenter: CGPoint.init(x: buttonHeight/2, y: buttonHeight/2), radius: buttonHeight/2, startAngle: 0, endAngle: .pi/4, clockwise: false)
        buttonPath.addLine(to: CGPoint.init(x: 0, y: buttonHeight/2))
        buttonPath.close()
        
        let buttonLayer = CAShapeLayer()
        buttonLayer.path = buttonPath.cgPath
        buttonLayer.fillColor = UIColor.white.cgColor
        buttonLayer.shadowRadius = 0
        buttonLayer.shadowColor = UIColor.init(hex: 0xC3C3C3).cgColor
        buttonLayer.shadowOpacity = 1
        buttonLayer.shadowOffset = CGSize.init(width: 0, height: 3)
        self.layer.insertSublayer(buttonLayer, below: self.titleLabel?.layer)
    }
}
