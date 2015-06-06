//
//  ResultsViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIApplicationDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var infoButtonObj: UIButton!
    @IBOutlet weak var pickerListObj: UIPickerView!
    @IBOutlet weak var pickerBtnObj: UIButton!
    @IBOutlet weak var durationLabelObj: UIButton!
    
    @IBOutlet weak var beerCountUI: UILabel!
    @IBOutlet weak var wineCountUI: UILabel!
    @IBOutlet weak var shotCountUI: UILabel!
    @IBOutlet weak var mixerCountUI: UILabel!
    
    let BeerObj = DrinkClass(dt: "beer")
    let WineObj = DrinkClass(dt: "wine")
    let ShotObj = DrinkClass(dt: "shot")
    let MixerObj = DrinkClass(dt: "mixer")
    
    var duration = ["All Time", "This Year", "This Month", "This Week", "Today", "Session"]
    var rowSelected = Int()
    let defaultDuration: Int = 0
    
    //Dismisses the view
    @IBAction func trackingButtonAction(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: {})
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //Displays the picker and picker button
    @IBAction func durationBtnAction(sender: AnyObject) {
        pickerListObj.hidden = false
        pickerBtnObj.hidden = false
    }
    
    //"Done" Button in picker
    @IBAction func pickerButtonActn(sender: AnyObject) {
        setTotalsBasedOnDuration(rowSelected)
        
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true
    }
    
    //Updates the totals based on the duration
    func setTotalsBasedOnDuration(selectedDuration: Int) {
        
        //Then display new totals based on duration
        switch(selectedDuration) {
        case 0:
            //all time
            beerCountUI.text = String(BeerObj.getAllTotal())
            wineCountUI.text = String(WineObj.getAllTotal())
            shotCountUI.text = String(ShotObj.getAllTotal())
            mixerCountUI.text = String(MixerObj.getAllTotal())
            break
        case 1:
            //this year
            beerCountUI.text = String(BeerObj.getYearTotal())
            wineCountUI.text = String(WineObj.getYearTotal())
            shotCountUI.text = String(ShotObj.getYearTotal())
            mixerCountUI.text = String(MixerObj.getYearTotal())
            break
        case 2:
            //this month
            beerCountUI.text = String(BeerObj.getMonthlyTotal())
            wineCountUI.text = String(WineObj.getMonthlyTotal())
            shotCountUI.text = String(ShotObj.getMonthlyTotal())
            mixerCountUI.text = String(MixerObj.getMonthlyTotal())
            break
        case 3:
            //this week
            beerCountUI.text = String(BeerObj.getWeeklyTotal())
            wineCountUI.text = String(WineObj.getWeeklyTotal())
            shotCountUI.text = String(ShotObj.getWeeklyTotal())
            mixerCountUI.text = String(MixerObj.getWeeklyTotal())
            break
        case 4:
            //today's total
            beerCountUI.text = String(BeerObj.getTodayTotal())
            wineCountUI.text = String(WineObj.getTodayTotal())
            shotCountUI.text = String(ShotObj.getTodayTotal())
            mixerCountUI.text = String(MixerObj.getTodayTotal())
        case 5:
            //last session
            beerCountUI.text = String(BeerObj.getSessionTotal()) //getLastSessionTotal())
            wineCountUI.text = String(WineObj.getSessionTotal()) //.getLastSessionTotal())
            shotCountUI.text = String(ShotObj.getSessionTotal())  //.getLastSessionTotal())
            mixerCountUI.text = String(MixerObj.getSessionTotal()) //.getLastSessionTotal())
            break
        default:
            break
        }

        //Get total of all drinks
        var allTotal: Int = beerCountUI.text!.toInt()! + wineCountUI.text!.toInt()! + shotCountUI.text!.toInt()! + mixerCountUI.text!.toInt()!
        
        //Update the Duration Button Title wit all drink total
        durationLabelObj.setTitle(duration[selectedDuration], forState: .Normal) //"\(allTotal) Drinks", forState: .Normal)
    }
    
    
    //PICKER: Number of cols
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //PICKER: Number of rows
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    //PICKER: Data in rows
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return duration[row]
    }

    //PICKER: Set the rowSelected value
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
    
    //Handles the left and right swiping
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            println("Swipe Left")
            //Go to info view
        }
        
        if (sender.direction == .Right) {
            println("Swipe Right")
            self.dismissViewControllerAnimated(true, completion: {})
        }
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Swipe Recognition
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        //Default Drink Counts to All
        setTotalsBasedOnDuration(self.defaultDuration)
        
        //Set the picker delegate
        pickerListObj.dataSource = self
        pickerListObj.delegate = self
        
        //Hide the picker
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true
        
        //Default Drink Counts to All
        setTotalsBasedOnDuration(self.defaultDuration)
    }
    
}
