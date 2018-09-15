
//
//  StepperViewController.swift
//  Animations
//
//  Created by Aditya Jain on 9/15/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class StepperViewController: UIViewController {
    
    let stepperContainer : UIView = UIView.init()
    let subtractButton : UIButton = UIButton.init(type: .system)
    let countLabel : UILabel = UILabel.init()
    let addButton : UIButton = UIButton.init(type: .system)
    
    var count : Int = 0
    
    //Colors
    let peachColor : UIColor = UIColor.init(hex: 0xff7270)
    let textEnabledColor : UIColor = UIColor.init(hex: 0x303030)
    let textDisabledColor : UIColor = UIColor.init(hex: 0xd4cfcf)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = peachColor
        
        let margins = view.layoutMarginsGuide
        
        stepperContainer.backgroundColor = UIColor.white
        stepperContainer.layer.backgroundColor = UIColor.white.cgColor
        stepperContainer.layer.cornerRadius = 4
        stepperContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stepperContainer)
        var topPadding : CGFloat = 0
        if let navVC = self.navigationController{
            topPadding = topPadding + navVC.navigationBar.bounds.height
        }
        stepperContainer.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0).isActive = true
        stepperContainer.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0).isActive = true
        stepperContainer.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        subtractButton.setTitle("-", for: .normal)
        subtractButton.setTitleColor(textDisabledColor, for: .normal)
        subtractButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        subtractButton.addTarget(self, action: #selector(self.doSubtract), for: .touchUpInside)
        subtractButton.translatesAutoresizingMaskIntoConstraints = false
        stepperContainer.addSubview(subtractButton)
        subtractButton.leadingAnchor.constraint(equalTo: stepperContainer.leadingAnchor, constant: 16).isActive = true
        subtractButton.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor, constant: 0).isActive = true
        
        countLabel.text = "0"
        countLabel.font = UIFont.boldSystemFont(ofSize: 16)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.textColor = textEnabledColor
        stepperContainer.addSubview(countLabel)
        countLabel.leadingAnchor.constraint(equalTo: subtractButton.trailingAnchor, constant: 16).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor, constant: 0).isActive = true
        
        addButton.setTitle("+", for: .normal)
        addButton.setTitleColor(textEnabledColor, for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        addButton.addTarget(self, action: #selector(self.doAdd), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        stepperContainer.addSubview(addButton)
        addButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 16).isActive = true
        addButton.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor, constant: 0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: stepperContainer.trailingAnchor, constant: -16).isActive = true
    }
    
    @objc private func doSubtract() {
        count = count - 1
        UIView.transition(with: stepperContainer, duration: 0.35, options: [.curveEaseInOut, .transitionFlipFromRight], animations: {
            self.countLabel.text = String.localizedStringWithFormat("%d", self.count)
        })
        if(count == 0){
            subtractButton.isEnabled = false
            subtractButton.setTitleColor(textDisabledColor, for: .normal)
        }
    }
    
    @objc private func doAdd() {
        subtractButton.isEnabled = true
        subtractButton.setTitleColor(textEnabledColor, for: .normal)
        count = count + 1
        UIView.transition(with: stepperContainer, duration: 0.35, options: [.curveEaseInOut, .transitionFlipFromLeft], animations: {
            self.countLabel.text = String.localizedStringWithFormat("%d", self.count)
        })
    }
}
