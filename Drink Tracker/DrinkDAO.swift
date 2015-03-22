//
//  DrinkDAO.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/13/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class DrinkDAO: NSObject {
    
    private var EntityName: String = "DrinkEvents"
    private var appDel = AppDelegate()
    private var context = NSManagedObjectContext()
    private var DrinkType = String()

    
    override init() {
        super.init()
        
    }
    
    init(drinkType: String) {
        super.init()
        
        DrinkType = drinkType
        
        appDel = UIApplication.sharedApplication().delegate as AppDelegate
        context = appDel.managedObjectContext!
    }
    
    func saveDrinkEvent(dateDict: Dictionary<String, Any>)->Bool {
        //Get Model for the Drink Event
        var newDrinkEvent: NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName(self.EntityName, inManagedObjectContext: self.context) as NSManagedObject
        
        //Extract data from Date Dictionary
        var dayAsNsNum: NSNumber = (dateDict["dayAsInt"] != nil ? dateDict["dayAsInt"] : 0)  as NSNumber
        var dayStr: String = (dateDict["dayOfWeekAsStr"] != nil ? dateDict["dayOfWeekAsStr"] : "") as String
        var hour: NSNumber = (dateDict["hour"] != nil ? dateDict["hour"] : 0 ) as NSNumber
        var min: NSNumber = (dateDict["minute"] != nil ? dateDict["minute"] : 0 ) as NSNumber
        var month: NSNumber = (dateDict["month"] != nil ? dateDict["month"] : 0) as NSNumber
        var sec: NSNumber = (dateDict["seconds"] != nil ? dateDict["seconds"] : 0) as NSNumber
        var wkInMonth: NSNumber = (dateDict["weekInMonth"] != nil ? dateDict["weekInMonth"] : 0) as NSNumber
        var year: NSNumber = (dateDict["year"] != nil ? dateDict["year"] : 0) as NSNumber
        
        //Add fields to the Event
        newDrinkEvent.setValue(dayAsNsNum, forKey: "dayAsInt")
        newDrinkEvent.setValue(dayStr, forKey: "dayAsString")
        newDrinkEvent.setValue(self.DrinkType, forKey: "drinkType")
        newDrinkEvent.setValue(hour, forKey: "hour")
        newDrinkEvent.setValue(min, forKey: "minute")
        newDrinkEvent.setValue(month, forKey: "month")
        newDrinkEvent.setValue(sec, forKey: "second")
        newDrinkEvent.setValue(wkInMonth, forKey: "weekInMonth")
        newDrinkEvent.setValue(year, forKey: "year")
        
        //Save the Event
        var err: NSErrorPointer = nil
        context.save(err)
        
        if err != nil {
            NSLog("Error Saving Data: \(err)")
            return false
        }
        else {
            NSLog("Data Save Successful: \(newDrinkEvent)")
            return true
        }
    }
    
    func getAllTimeTotal()->Int {
        
        var request = NSFetchRequest(entityName: self.EntityName)
        request.predicate = NSPredicate(format: "drinkType == %@", self.DrinkType)
        request.returnsObjectsAsFaults = false
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {

            println(results!)
            println("Total Beers: \(results!.count)")
            
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getYearlyTotal()->Int {
        return 150
    }
    
    func getMonthlyTotal()->Int {
        return 75
    }
    
    func getWeeklyTotal()->Int {
        return 40
    }
    
    func getDailyTotal()->Int {
        return 10
    }
    
    func getSessionTotal()->Int {
        return 1
    }
    
}