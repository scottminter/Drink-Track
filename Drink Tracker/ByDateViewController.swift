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
    
    @IBOutlet weak var BeerLabel: UILabel!
    @IBOutlet weak var WineLabel: UILabel!
    @IBOutlet weak var ShotLabel: UILabel!
    @IBOutlet weak var MixerLabel: UILabel!
    
    @IBOutlet weak var pickerTopPadding: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    @IBOutlet weak var dateDoneButton: UIButton!
    
    let BeerObj = DrinkClass(dt: "beer")
    let WineObj = DrinkClass(dt: "wine")
    let ShotObj = DrinkClass(dt: "shot")
    let MixerObj = DrinkClass(dt: "mixer")
    
    var startDate = String()
    var endDate = String()
    var tempDate = String()
    var dateToSet = String()
    
    @IBAction func doneWithDate(sender: AnyObject) {
        hidePicker()
        
        if !dateToSet.isEmpty && dateToSet == "startDate" {
            startDate = getDateFromPicker()
            //set min for picker to this date
            var startAsDateObj: NSDate = getDateObjFromStr(startDate)
            datePicker.minimumDate = startAsDateObj
            startDateButton.setTitle(startDate, forState: .Normal)
        }
        else if !dateToSet.isEmpty && dateToSet == "endDate" {
            endDate = getDateFromPicker()
            //set max for picker to this date
            var endAsDateObj: NSDate = getDateObjFromStr(endDate)
            datePicker.maximumDate = endAsDateObj
            endDateButton.setTitle(endDate, forState: .Normal)
        }
        
        if !startDate.isEmpty && !endDate.isEmpty {
            updateTotalsByDates(startDate, endDate: endDate)
        }
    }
    
    func updateTotalsByDates(startDate: String, endDate: String) {
        var beerTotal = BeerObj.getTotalByDates(startDate, endDate: endDate)
        BeerLabel.text = String(beerTotal)
        
        var wineTotal = WineObj.getTotalByDates(startDate, endDate: endDate)
        WineLabel.text = String(wineTotal)
        
        var shotTotal = ShotObj.getTotalByDates(startDate, endDate: endDate)
        ShotLabel.text = String(shotTotal)
        
        var mixerTotal = MixerObj.getTotalByDates(startDate, endDate: endDate)
        MixerLabel.text = String(mixerTotal)
    }
    
    func getDateObjFromStr(iDate: String)->NSDate {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy" //"dd-MM-yyyy HH:mm"
        var date: NSDate = formatter.dateFromString(iDate)!
        
        return date
    }
    
    func getDateFromPicker()->String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy" //"dd-MM-yyyy HH:mm"
        var strDate: String = dateFormatter.stringFromDate(datePicker.date)
        
        return strDate
    }

    //Unhides the date picker
    @IBAction func showDatePicker(sender: AnyObject) {
        showPicker()
        var calledBy: String = sender.restorationIdentifier!!
        
        dateToSet = calledBy
    }
    
    //Handles the Date Picker changes
    @IBAction func datePickerAction(sender: AnyObject) {
        /*
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(datePicker.date)

        tempDate = strDate
        */
    }
    
    @IBAction func backToDuration(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func showPicker() {
        //Show picker, done button and picker padding
        self.datePicker.hidden = false
        self.pickerTopPadding.hidden = false
        self.dateDoneButton.hidden = false
    }
    
    func hidePicker() {
        //Hide picker, done button and picker padding
        self.datePicker.hidden = true
        self.pickerTopPadding.hidden = true
        self.dateDoneButton.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let datePickBGColor: UIColor = UIColor(white: 1.0, alpha: 0.84)
        self.datePicker.backgroundColor = datePickBGColor
        
        hidePicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {}
}