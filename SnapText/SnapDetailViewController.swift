//
//  SnapDetailViewController.swift
//  SnapText
//
//  Created by Arshin Jain on 6/29/17.
//  Copyright © 2017 Arshin Jain. All rights reserved.
//

import UIKit

class SnapDetailViewController: UIViewController {

    // MARK: Properties
    var snap: Snap!
    
    // Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

}
