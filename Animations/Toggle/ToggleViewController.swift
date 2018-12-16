//
//  ToggleViewController.swift
//  Animations
//
//  Created by Aditya Jain on 12/16/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class ToggleViewController: UIViewController {
    
    let toggleContainer : UIView = .init()
    let circleA : UIView = .init()
    let circleB : UIView = .init()
    
    var circleATopConstraint: NSLayoutConstraint?
    var circleAHeightConstraint: NSLayoutConstraint?
    var circleBTopConstraint: NSLayoutConstraint?
    var circleBHeightConstraint: NSLayoutConstraint?
    
    let buttonA : UIButton = .init(type: .system)
    let buttonB : UIButton = .init(type: .system)

    let circleRadius : CGFloat = 32
    
    var stateBottom : Bool = false
    
    //Colors
    let aquamarineColor : UIColor = .init(hex: 0x78f2e4)
    let textEnabledColor : UIColor = UIColor.init(hex: 0x303030)
    let textDisabledColor : UIColor = UIColor.init(hex: 0xd4cfcf)
    let toggleEnabledColor : UIColor = .init(hex: 0x5fc7bd)
    let toggleDisabledColor : UIColor = .init(hex: 0xdff3f1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = aquamarineColor
        
        let margins = view.layoutMarginsGuide
        
        toggleContainer.backgroundColor = UIColor.white
        toggleContainer.layer.backgroundColor = UIColor.white.cgColor
        toggleContainer.layer.cornerRadius = 16
        toggleContainer.translatesAutoresizingMaskIntoConstraints = false
        toggleContainer.layer.shadowOffset = CGSize.init(width: 0, height: 2)
        toggleContainer.layer.shadowColor = UIColor.black.cgColor
        toggleContainer.layer.shadowOpacity = 0.1
        toggleContainer.layer.shadowRadius = 15
        view.addSubview(toggleContainer)
        toggleContainer.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        toggleContainer.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        toggleContainer.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        circleA.layer.cornerRadius = circleRadius/2
        circleA.clipsToBounds = true
        circleA.backgroundColor = toggleEnabledColor
        circleA.translatesAutoresizingMaskIntoConstraints = false
        toggleContainer.addSubview(circleA)
        circleA.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor, constant: 32).isActive = true
        circleATopConstraint = circleA.topAnchor.constraint(equalTo: toggleContainer.topAnchor, constant: 32)
        circleATopConstraint?.isActive = true
        circleAHeightConstraint = circleA.heightAnchor.constraint(equalToConstant: circleRadius)
        circleAHeightConstraint?.isActive = true
        circleA.widthAnchor.constraint(equalToConstant: circleRadius).isActive = true
        
        buttonA.setTitleColor(textEnabledColor, for: .normal)
        buttonA.setTitle("Android", for: .normal)
        buttonA.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonA.translatesAutoresizingMaskIntoConstraints = false
        buttonA.addTarget(self, action: #selector(self.didTapButtonA), for: .touchUpInside)
        buttonA.isEnabled = false
        toggleContainer.addSubview(buttonA)
        buttonA.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor, constant: 80).isActive = true
        buttonA.topAnchor.constraint(equalTo: toggleContainer.topAnchor, constant: 30).isActive = true
        buttonA.trailingAnchor.constraint(equalTo: toggleContainer.trailingAnchor, constant: -96).isActive = true
        
        circleB.layer.cornerRadius = circleRadius/2
        circleB.clipsToBounds = true
        circleB.backgroundColor = toggleDisabledColor
        circleB.translatesAutoresizingMaskIntoConstraints = false
        toggleContainer.addSubview(circleB)
        circleB.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor, constant: 32).isActive = true
        circleBTopConstraint = circleB.topAnchor.constraint(equalTo: toggleContainer.topAnchor, constant: 96)
        circleBTopConstraint?.isActive = true
        circleBHeightConstraint = circleB.heightAnchor.constraint(equalToConstant: circleRadius)
        circleBHeightConstraint?.isActive = true
        circleB.widthAnchor.constraint(equalToConstant: circleRadius).isActive = true
        

        buttonB.setTitleColor(textDisabledColor, for: .normal)
        buttonB.setTitle("iOS", for: .normal)
        buttonB.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonB.titleLabel?.textAlignment = .left
        buttonB.translatesAutoresizingMaskIntoConstraints = false
        buttonB.isEnabled = true
        buttonB.addTarget(self, action: #selector(self.didTapButtonB), for: .touchUpInside)
        toggleContainer.addSubview(buttonB)
        buttonB.leadingAnchor.constraint(equalTo: toggleContainer.leadingAnchor, constant: 80).isActive = true
        buttonB.topAnchor.constraint(equalTo: toggleContainer.topAnchor, constant: 94).isActive = true
        
        toggleContainer.bringSubview(toFront: circleA)
        
    }
    
    @objc func didTapButtonA(){
        if(stateBottom == false){
            return
        }
        circleAHeightConstraint?.constant = 96
        circleATopConstraint?.constant = 32
        UIView.animate(withDuration: 0.27, delay: 0, options: .curveEaseInOut, animations: {
            self.toggleContainer.layoutIfNeeded()
        }) { (_) in
            self.circleBTopConstraint?.constant = 96
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.375, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.toggleContainer.layoutIfNeeded()
            }, completion: { (_) in
                self.circleAHeightConstraint?.constant = self.circleRadius
                UIView.animate(withDuration: 0.27, delay: 0.05, options: .curveEaseInOut, animations: {
                    self.toggleContainer.layoutIfNeeded()
                }) { (_) in
                    self.stateBottom = false
                    self.toggleContainer.bringSubview(toFront: self.circleA)
                }
            })
        }
        UIView.animate(withDuration: 1.2, animations: {
            self.buttonA.setTitleColor(self.textEnabledColor, for: .normal)
            self.buttonB.setTitleColor(self.textDisabledColor, for: .normal)
        }) { (_) in
            self.buttonA.isEnabled = false
            self.buttonB.isEnabled = true
        }
    }
    
    @objc func didTapButtonB(){
        if(stateBottom == true){
            return
        }
        circleBHeightConstraint?.constant = 96
        circleBTopConstraint?.constant = 32
        UIView.animate(withDuration: 0.27, delay: 0, options: .curveEaseInOut, animations: {
            self.toggleContainer.layoutIfNeeded()
        }) { (_) in
            self.circleATopConstraint?.constant = 96
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.375, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.toggleContainer.layoutIfNeeded()
            }, completion: { (_) in
                self.circleBHeightConstraint?.constant = self.circleRadius
                UIView.animate(withDuration: 0.27, delay: 0.05, options: .curveEaseInOut, animations: {
                    self.toggleContainer.layoutIfNeeded()
                }) { (_) in
                    self.stateBottom = true
                    self.toggleContainer.bringSubview(toFront: self.circleB)
                }
            })
        }
        UIView.animate(withDuration: 1.2, animations: {
            self.buttonA.setTitleColor(self.textDisabledColor, for: .normal)
            self.buttonB.setTitleColor(self.textEnabledColor, for: .normal)
        }) { (_) in
            self.buttonA.isEnabled = true
            self.buttonB.isEnabled = false
        }
    }
}

