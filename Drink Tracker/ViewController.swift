//
//  ViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var infoButton: UIButton!
    
    //Upper Left Button
    @IBOutlet weak var ULButton: UIButton!
    @IBOutlet weak var ULView: UIView!
    
    
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var wineCountLabel: UILabel!
    @IBOutlet weak var shotCountLabel: UILabel!
    @IBOutlet weak var mixerCountLabel: UILabel!

    
    let BeerObj = Beer()
    let WineObj = Wine()
    let ShotObj = Shot()
    let MixerObj = Mixer()
    
    /*
     * Drink Buttons Action
     */
    @IBAction func drinkSelected(sender: AnyObject) {
        var buttonId = sender.restorationIdentifier!!
        
        let dateDict = getFormattedDate()
        
        if buttonId == "beer" {
            BeerObj.saveBeerEvent(dateDict)
            beerCountLabel.text = String(BeerObj.getSessionTotal())
            beerCountLabel.alpha = 1.0
            beerCountLabel.fadeOut()
        }
        else if buttonId == "wine" {
            WineObj.saveWineEvent(dateDict)
            wineCountLabel.text = String(WineObj.getSessionTotal())
            wineCountLabel.alpha = 1.0
            wineCountLabel.fadeOut()
        }
        else if buttonId == "shot" {
            ShotObj.saveShotEvent(dateDict)
            shotCountLabel.text = String(ShotObj.getSessionTotal())
            shotCountLabel.alpha = 1.0
            shotCountLabel.fadeOut()
        }
        else if buttonId == "mixer" {
            MixerObj.saveMixerEvent(dateDict)
            mixerCountLabel.text = String(MixerObj.getSessionTotal())
            mixerCountLabel.alpha = 1.0
            mixerCountLabel.fadeOut()
        }
    }
    
    /**
     *  Updates the Counts on each button
     */
    func updateButtonCounts() {
        beerCountLabel.text = String(BeerObj.getSessionTotal())
        wineCountLabel.text = String(WineObj.getSessionTotal())
        shotCountLabel.text = String(ShotObj.getSessionTotal())
        mixerCountLabel.text = String(MixerObj.getSessionTotal())
    }
    
    /**
     * Returns a Dictionary object containing various date info
     */
    func getFormattedDate()->Dictionary<String, Any> {
        var dateObj = Dictionary<String, Any>()
        
        var date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitWeekday | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let year = components.year
        let month = components.month
        let dayAsInt = components.day
        let dayOfWeekAsInt = components.weekday
        let weekInMonth = (dayAsInt % 7 == 0) ? dayAsInt / 7 : dayAsInt / 7 + 1
        let hour = components.hour
        let minutes = components.minute
        let seconds = components.second
        
        var dayAsStr = String()
        switch dayOfWeekAsInt {
        case 1:
            dayAsStr = "Sunday"
            break
        case 2:
            dayAsStr = "Monday"
            break
        case 3:
            dayAsStr = "Tuesday"
            break
        case 4:
            dayAsStr = "Wednesday"
            break
        case 5:
            dayAsStr = "Thursday"
            break
        case 6:
            dayAsStr = "Friday"
            break
        case 7:
            dayAsStr = "Saturday"
            break
        default:
            dayAsStr = ""
            break
        }
        
        dateObj["year"] = year
        dateObj["month"] = month
        dateObj["weekInMonth"] = weekInMonth
        dateObj["dayAsInt"] = dayAsInt
        dateObj["dayOfWeekAsInt"] = dayOfWeekAsInt
        dateObj["dayOfWeekAsStr"] = dayAsStr
        dateObj["hour"] = hour
        dateObj["minute"] = minutes
        dateObj["seconds"] = seconds
        
        return dateObj
    }
    
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
        
        beerCountLabel.alpha = 0.0
        wineCountLabel.alpha = 0.0
        shotCountLabel.alpha = 0.0
        mixerCountLabel.alpha = 0.0
        
        updateButtonCounts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        whichView()
        
        updateButtonCounts()
    }
}

