//
//  DrinkTypeInfoViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/11/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class DrinkTypeInfoViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
   
    @IBAction func backButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {}
}