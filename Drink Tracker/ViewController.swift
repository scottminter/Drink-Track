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
    
    
    /**
     *  Drink Processing Functions
     */
    func processBeer(date: Dictionary<String, Any>) {
        println("yay beer")
    }
    
    func processWine(date: Dictionary<String, Any>) {
        println("yay wine")
    }
    
    func processShot(date: Dictionary<String, Any>) {
        println("yay shot")
    }
    
    func processMixer(date: Dictionary<String, Any>) {
        println("yay mixer")
    }

    
    /*
     * Drink Buttons Action
     */
    @IBAction func drinkSelected(sender: AnyObject) {
        var buttonId = sender.restorationIdentifier!!
        
        let dateDict = getFormattedDate()
println(dateDict)
        
        if buttonId == "beer" {
            processBeer(dateDict)
        }
        else if buttonId == "wine" {
            processWine(dateDict)
        }
        else if buttonId == "shot" {
            processShot(dateDict)
        }
        else if buttonId == "mixer" {
            processMixer(dateDict)
        }
    }
    
    func getFormattedDate()->Dictionary<String, Any> {
        var dateObj = Dictionary<String, Any>()
        
        var date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitWeekday | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let year = components.year
        let month = components.month
        let dayAsInt = components.day
        let dayOfWeekAsInt = components.weekday
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
    
    //Draws a border around the info button
    func makeInfoButtonCircle() {
        infoButton.layer.borderWidth = 0.8
        infoButton.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //makeInfoButtonCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        whichView()
    }
}

