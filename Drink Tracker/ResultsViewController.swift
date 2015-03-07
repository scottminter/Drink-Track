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
    
    var beerTotal = 0
    var wineTotal = 0
    var shotTotal = 0
    var mixerTotal = 0
    
    var duration = ["All Time", "This Year", "This Month", "This Week", "Today", "This Session"]
    var rowSelected = Int()
    
    //Displays the picker and picker button
    @IBAction func durationBtnAction(sender: AnyObject) {
        pickerListObj.hidden = false
        pickerBtnObj.hidden = false
    }
    
    //Done button in picker
    @IBAction func pickerButtonActn(sender: AnyObject) {
        println("row: \(rowSelected), value: \(duration[rowSelected])")
        
        setTotalsBasedOnDuration(rowSelected)
        
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true
    }
    
    //Updates the totals based on the duration
    func setTotalsBasedOnDuration(selectedDuration: Int) {

        //Get the totals based on duration
        var totalsObj: Dictionary<String, Int>  = getTotalsByDuration(rowSelected)
        beerTotal = totalsObj["beerTotal"]!
        wineTotal = totalsObj["wineTotal"]!
        shotTotal = totalsObj["shotTotal"]!
        mixerTotal = totalsObj["mixerTotal"]!
        
        //Update the totals in the UI
        updateTotalsInUI()
        
        //Update the Duration Button Title
        durationLabelObj.setTitle(duration[rowSelected], forState: .Normal)
    }
    
    //Set totals in UI
    func updateTotalsInUI() {
        beerCountUI.text = String(beerTotal)
        wineCountUI.text = String(wineTotal)
        shotCountUI.text = String(shotTotal)
        mixerCountUI.text = String(mixerTotal)
    }
    
    //Handles the logic to get type totals by duration
    func getTotalsByDuration(dur: Int) -> Dictionary<String, Int> {
        var totals = Dictionary<String, Int>()
        
        var beer = 0
        var wine = 0
        var shot = 0
        var mixer = 0
        
        switch(dur) {
        case 0:
            //all time
            beer = 100
            wine = 100
            shot = 100
            mixer = 100
            break
        case 1:
            //this year
            beer = 60
            wine = 60
            shot = 60
            mixer = 60
            break
        case 2:
            //this month
            beer = 40
            wine = 40
            shot = 40
            mixer = 40
            break
        case 3:
            //this week
            beer = 20
            wine = 20
            shot = 20
            mixer = 20
            break
        case 4:
            //today
            beer = 10
            wine = 10
            shot = 10
            mixer = 10
            break
        case 5:
            //this session
            beer = 5
            wine = 5
            shot = 5
            mixer = 5
            break
        default:
            break
        }
        
        totals["beerTotal"] = beer
        totals["wineTotal"] = wine
        totals["shotTotal"] = shot
        totals["mixerTotal"] = mixer
        
        return totals;
    }
    
    //Output all totals
    func displayTotals() {
        println("beer: \(beerTotal), wine: \(wineTotal), shot: \(shotTotal), mixer: \(mixerTotal)")
    }
    
    //Number of cols
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of rows
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    //Data in rows
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return duration[row]
    }

    //Set the rowSelected value
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }

    func whichView() {
        println("Results View")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Default to Session
        rowSelected = 0
        setTotalsBasedOnDuration(rowSelected)
        
        pickerListObj.dataSource = self
        pickerListObj.delegate = self
        
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        whichView()
        pickerListObj.hidden = true
        pickerBtnObj.hidden = true
    }
    
}
