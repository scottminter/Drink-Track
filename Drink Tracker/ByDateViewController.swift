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
    let TimeTrack = TimeKeeper()
    
    var startDate = String()
    var endDate = String()
    var tempDate = String()
    var dateToSet = String()
    
    /**
     * Action for the "Done" button on the date picker
     */
    @IBAction func doneWithDate(sender: AnyObject) {
        
        // Hide the date picker
        hidePicker()
        
        // If the date is for the start date
        if !dateToSet.isEmpty && dateToSet == "startDate" {
            startDate = getDateFromPicker()
            //set min for picker to this date
            var startAsDateObj: NSDate = getDateObjFromStr(startDate)
            datePicker.minimumDate = startAsDateObj
            self.setMaxDateToCurrent()

            //update the button's title to the start date
            startDateButton.setTitle(startDate, forState: .Normal)
        }
        // If the date is for the end date
        else if !dateToSet.isEmpty && dateToSet == "endDate" {
            endDate = getDateFromPicker()

            //set max for picker to this date
            var endAsDateObj: NSDate = getDateObjFromStr(endDate)
            datePicker.maximumDate = endAsDateObj
            datePicker.minimumDate = nil

            //update the button's title to the end date
            endDateButton.setTitle(endDate, forState: .Normal)
        }
        
        // Once a start and end date have been selected then we update all the totals
        if !startDate.isEmpty && !endDate.isEmpty {
            updateTotalsByDates(startDate, endDate: endDate)
        }
    }

    /**
     * Controls updating the totals for each type of drink
     */
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
    
    /**
     * Returns an NSDate Object from a date string
     */
    func getDateObjFromStr(iDate: String)->NSDate {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        var date: NSDate = formatter.dateFromString(iDate)!
        
        return date
    }
    
    /**
     * Gets a MM-dd-yyyy date string from date picker
     */
    func getDateFromPicker()->String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        var strDate: String = dateFormatter.stringFromDate(datePicker.date)
        
        return strDate
    }

    /**
     * Displays the date picker
     */
    @IBAction func showDatePicker(sender: AnyObject) {
        showPicker()
        var calledBy: String = sender.restorationIdentifier!!
        
        dateToSet = calledBy
    }

    /**
     * Handles the navigation back to the "Duration" view.
     */
    @IBAction func backToDuration(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
     * Disables Portrait
     */
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    /**
     * Displays all the objects that make up the date picker.
     *
     * This includes the picker, done button and picker padding.
     */
    func showPicker() {
        self.datePicker.hidden = false
        self.pickerTopPadding.hidden = false
        self.dateDoneButton.hidden = false
    }

    /**
     * Hides all the objects that make up the date picker.
     *
     * This includes the picker, done button and picker padding.
     */
    func hidePicker() {
        self.datePicker.hidden = true
        self.pickerTopPadding.hidden = true
        self.dateDoneButton.hidden = true
    }
    
    func setMaxDateToCurrent() {
        // Set max date for start and end date as today
        var currTimeAsString: String = TimeTrack.getCurrentDateAsString()
        var currDateObj: NSDate = self.getDateObjFromStr(currTimeAsString)
        datePicker.maximumDate = currDateObj
    }
    
    func setMinDateToCurrent() {
        // Set max date for start and end date as today
        var currTimeAsString: String = TimeTrack.getCurrentDateAsString()
        var currDateObj: NSDate = self.getDateObjFromStr(currTimeAsString)
        datePicker.minimumDate = currDateObj
    }
    
    /**
     * Gets called when view loads.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets the color and transparency level for the date picker
        let datePickBGColor: UIColor = UIColor(white: 1.0, alpha: 0.84)
        self.datePicker.backgroundColor = datePickBGColor
        
        // Hide the Date picker
        hidePicker()
        
        self.setMaxDateToCurrent()
    }
    
    /**
     * Handles Memory Warnings.
     */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * Gets called when view appears.
     */
    override func viewDidAppear(animated: Bool) {}
}