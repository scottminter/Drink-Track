//
//  ResultsViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController {
    
    func whichView() {
        println("Results View")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        whichView()
    }
    
}
