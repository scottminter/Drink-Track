//
//  ByDateViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 4/10/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class ByDateViewController: UIViewController, UIPickerViewDelegate, UIApplicationDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Handles the Date Picker changes
    @IBAction func datePickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        
        println(strDate)
    }
    
    @IBAction func backToDuration(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
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
    }
}