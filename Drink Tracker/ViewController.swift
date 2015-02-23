//
//  ViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Upper Left Button
    @IBOutlet weak var ULButton: UIButton!
    @IBOutlet weak var ULView: UIView!
    
    var BeerIcon = UIImage(named: "beer_230_230.png")
    
    func whichView() {
        println("Tracking View")
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
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

