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
    
    @IBAction func startButtonAction(sender: AnyObject) {
        //If end date has been selected, then set the end date
        //as the new max date for the picker
        if !self.endDate.isEmpty {
            let endDateObj: NSDate = getDateObjFromStr(self.endDate)
            self.datePicker.maximumDate = endDateObj
        }
        
        showPicker()
        self.dateToSet = sender.restorationIdentifier!!
    }
    
    @IBAction func endButtonAction(sender: AnyObject) {
        //If start date has been selected then set the the start date
        //as the new min date for picker
        if !self.startDate.isEmpty {
            let startDateObj: NSDate = getDateObjFromStr(self.startDate)
            self.datePicker.minimumDate = startDateObj
        }
        
        showPicker()
        self.dateToSet = sender.restorationIdentifier!!
    }
    
    
    /**
     * Action for the "Done" button on the date picker
     */
    @IBAction func doneWithDate(sender: AnyObject) {
        
        // Hide the date picker
        hidePicker()

        // If the date is for the start date
        if !dateToSet.isEmpty && dateToSet == "startDate" {
            //Get start date from picker
            startDate = getDateFromPicker()

            //update the button's title to the start date
            startDateButton.setTitle(startDate, forState: .Normal)
            
        }
        // If the date is for the end date
        else if !dateToSet.isEmpty && dateToSet == "endDate" {
            //Get end date from picker
            endDate = getDateFromPicker()

            //update the button's title to the end date
            endDateButton.setTitle(endDate, forState: .Normal)
            
        }
        
        // Once a start and end date have been selected then we update all the totals
        if !startDate.isEmpty && !endDate.isEmpty {
            self.datePicker.minimumDate = nil
            self.setMaxDateToCurrent()
            self.updateTotalsByDates(startDate, endDate: endDate)
        }
    }

    /**
     * Controls updating the totals for each type of drink
     */
    func updateTotalsByDates(startDate: String, endDate: String) {
        let beerTotal = BeerObj.getTotalByDates(startDate, endDate: endDate)
        BeerLabel.text = String(beerTotal)
        
        let wineTotal = WineObj.getTotalByDates(startDate, endDate: endDate)
        WineLabel.text = String(wineTotal)
        
        let shotTotal = ShotObj.getTotalByDates(startDate, endDate: endDate)
        ShotLabel.text = String(shotTotal)
        
        let mixerTotal = MixerObj.getTotalByDates(startDate, endDate: endDate)
        MixerLabel.text = String(mixerTotal)
    }
    
    /**
     * Returns an NSDate Object from a date string
     */
    func getDateObjFromStr(iDate: String)->NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let date: NSDate = formatter.dateFromString(iDate)!
        
        return date
    }
    
    /**
     * Gets a MM-dd-yyyy date string from date picker
     */
    func getDateFromPicker()->String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let strDate: String = dateFormatter.stringFromDate(datePicker.date)
        
        return strDate
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
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
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
        let currTimeAsString: String = TimeTrack.getCurrentDateAsString()
        let currDateObj: NSDate = self.getDateObjFromStr(currTimeAsString)
        datePicker.maximumDate = currDateObj
    }
    
    func setMinDateToCurrent() {
        // Set max date for start and end date as today
        let currTimeAsString: String = TimeTrack.getCurrentDateAsString()
        let currDateObj: NSDate = self.getDateObjFromStr(currTimeAsString)
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
        
        //Set pick max to current date
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