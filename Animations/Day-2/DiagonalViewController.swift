//
//  DiagonalViewController.swift
//  Animations
//
//  Created by Aditya Jain on 9/17/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class DiagonalViewController: UIViewController {
    
    let yellowContainer : UIView = UIView.init()
    var yellowHeightConstraint : NSLayoutConstraint?
    
    let pinkContainer : UIView = UIView.init()
    var pinkHeightConstraint : NSLayoutConstraint?
    
    //Colors
    let purpleColor : UIColor = UIColor.init(hex: 0x843cc4)
    let yellowColor : UIColor = UIColor.init(hex: 0xfff571)
    let pinkColor : UIColor = UIColor.init(hex: 0xff7acd)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = purpleColor
        
        pinkContainer.backgroundColor = pinkColor
        pinkContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinkContainer)
        pinkContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        pinkContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pinkContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pinkHeightConstraint = pinkContainer.heightAnchor.constraint(equalToConstant: 92)
        pinkHeightConstraint?.isActive = true
        
        yellowContainer.backgroundColor = yellowColor
        yellowContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yellowContainer)
        yellowContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        yellowContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        yellowContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        yellowHeightConstraint = yellowContainer.heightAnchor.constraint(equalToConstant: 92)
        yellowHeightConstraint?.isActive = true
        
        view.layoutIfNeeded()
        
        pinkHeightConstraint?.constant = 3*view.bounds.height/4
        yellowHeightConstraint?.constant = view.bounds.height/3
        UIView.animate(withDuration: 1.8, delay: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
