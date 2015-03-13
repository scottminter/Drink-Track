//
//  ResultsViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class ResultsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var infoButtonObj: UIButton!
    @IBOutlet weak var pickerListObj: UIPickerView!
    @IBOutlet weak var pickerBtnObj: UIButton!
    @IBOutlet weak var durationLabelObj: UIButton!
    
    @IBOutlet weak var beerCountUI: UILabel!
    @IBOutlet weak var wineCountUI: UILabel!
    @IBOutlet weak var shotCountUI: UILabel!
    @IBOutlet weak var mixerCountUI: UILabel!
    
    let BeerObj = Beer()
    let WineObj = Wine()
    let ShotObj = Shot()
    let MixerObj = Mixer()
    
    var duration = ["All Time", "This Year", "This Month", "This Week", "Today", "This Session"]
    var rowSelected = Int()
    
    @IBAction func trackingButtonAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});//This is intended to dismiss the Info sceen.
        println("pressed")
    }
    
    //Displays the picker and picker button
    @IBAction func durationBtnAction(sender: AnyObject) {
        pickerListObj.hidden = false
        pickerBtnObj.hidden = false
    }
    
    //"Done" Button in picker
    @IBAction func pickerButtonActn(sender: AnyObject) {
        println("row: \(rowSelected), value: \(duration[rowSelected])")
        
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
            //today
            beerCountUI.text = String(BeerObj.getTodayTotal())
            wineCountUI.text = String(WineObj.getTodayTotal())
            shotCountUI.text = String(ShotObj.getTodayTotal())
            mixerCountUI.text = String(MixerObj.getTodayTotal())
            break
        case 5:
            //this session
            beerCountUI.text = String(BeerObj.getSessionTotal())
            wineCountUI.text = String(WineObj.getSessionTotal())
            shotCountUI.text = String(ShotObj.getSessionTotal())
            mixerCountUI.text = String(MixerObj.getSessionTotal())
            break
        default:
            break
        }
        
        //Update the Duration Button Title
        durationLabelObj.setTitle(duration[rowSelected], forState: .Normal)
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
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Default to Session
        rowSelected = 0
        setTotalsBasedOnDuration(rowSelected)
        
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
    }
    
}
