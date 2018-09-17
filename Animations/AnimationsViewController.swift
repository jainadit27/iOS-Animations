//
//  AnimationsViewController.swift
//  Animations
//
//  Created by Aditya Jain on 9/14/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class AnimationsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let animations = ["Day 0 - Search Bar", "Day 1 - Stepper","Day 2 - Diagonal"]
    
    let tableView : UITableView = UITableView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect.init(origin: CGPoint.zero, size: view.bounds.size)
        view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "textCell")
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "textCell")
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = animations[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(indexPath.row == 0){
            let searchVC : SearchViewController = SearchViewController.init()
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
        else if(indexPath.row == 1){
            let stepperVC : StepperViewController = StepperViewController.init()
            self.navigationController?.pushViewController(stepperVC, animated: true)
        }
        else if(indexPath.row == 2){
            let diagonalVC : DiagonalViewController = DiagonalViewController.init()
            self.navigationController?.pushViewController(diagonalVC, animated: true)
        }
    }
    
}
