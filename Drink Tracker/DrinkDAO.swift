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
    private var TimeObj = TimeKeeper()

    
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

            //println(results!)
            println("Total Beers: \(results!.count)")
            
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getYearlyTotal()->Int {
        //Get the current date
        var dateDict: Dictionary = TimeObj.getFormattedDate()
        //Get the current year
        var currentYear: NSNumber = ((dateDict["year"] != nil ) ? dateDict["year"] : 0) as NSNumber

        //Set up request
        var request = NSFetchRequest(entityName: self.EntityName)
        //Build drink type predicate
        let predicate1 = NSPredicate(format: "drinkType == %@", self.DrinkType)
        //Build current year predicate
        let predicate2 = NSPredicate(format: "year == %@", currentYear)
        //Combine Predicates with an AND
        let allPredicates = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predicate1!, predicate2!])
        //Add predicates to request
        request.predicate = allPredicates
        
        //Get results
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            
            println("year counts: \(results!.count)")
            
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getMonthlyTotal()->Int {
        //Get Current Date
        var dateDict: Dictionary = TimeObj.getFormattedDate()
        //Get Current Month
        var currentMonth: NSNumber = ((dateDict["month"] != nil) ? dateDict["month"] : 0) as NSNumber
        
        //Set Up Request
        var request = NSFetchRequest(entityName: self.EntityName)
        //Build drink type predicate
        let predicate1 = NSPredicate(format: "drinkType == %@", self.DrinkType)
        //Build current year predicate
        let predicate2 = NSPredicate(format: "month == %@", currentMonth)
        //Combine Predicates with an AND
        let allPredicates = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predicate1!, predicate2!])
        //Add predicates to request
        request.predicate = allPredicates
        
        //Get Results
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            println("month counts \(results!.count)")
            
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getWeeklyTotal()->Int {
println("\n")
        //Get Date Dict
        var dateDict: Dictionary = TimeObj.getFormattedDate()

        //Get Day of Week
        var currentDayOfWeek: NSNumber = ((dateDict["dayOfWeekAsInt"] != nil) ? dateDict["dayOfWeekAsInt"] : 0) as NSNumber
        //Get Day of month
        var currentDayInMonth: NSNumber = ((dateDict["dayAsInt"] != nil) ? dateDict["dayAsInt"] : 0) as NSNumber
        //Get Month
        var currentMonth: NSNumber = ((dateDict["month"] != nil) ? dateDict["month"] : 0) as NSNumber
        //Get Year
        var currentYear: NSNumber = ((dateDict["year"] != nil) ? dateDict["year"] : 0) as NSNumber
//println("day of week: \(currentDayOfWeek), day in month: \(currentDayInMonth), month: \(currentMonth), year: \(currentYear)")
        //Determine if leap years
        var isLeapYear: Bool = TimeObj.isLeapYear(currentYear as Int)
//println("is leap year: \(isLeapYear)")
        
        //Determine Number of days in month
        var numOfDaysInMonth: Int = TimeObj.getNumberOfDaysInMonth(currentMonth as Int, isLeapYear: isLeapYear) as Int
//println("number of days in month: \(numOfDaysInMonth)")

//currentMonth = 1
//currentDayInMonth = 5
//currentDayOfWeek = 7
        var tempDayInMonth: Int = currentDayInMonth as Int
        for var i: Int = currentDayOfWeek as Int; i > 1; i-- {
            tempDayInMonth--
        }
        
        //Month at start of week
        var monthAtStartOfWeek: Int = currentMonth as Int
        //Day in month on Sunday of current week
        var dayInMonthAtStartOfWeek = tempDayInMonth
        //Year at Beginning of Week
        var yearAtStartOfWeek: Int = currentYear as Int
        
        //Handles weeks that cross months
        if tempDayInMonth <= 0 {
            //account for beginning of the year
            if monthAtStartOfWeek != 1 {
                monthAtStartOfWeek--
            }
            else {
                monthAtStartOfWeek = 12
                
                //back year off by 1 if it's January
                yearAtStartOfWeek--
            }
            
            var daysInPrevMonth: Int = TimeObj.getNumberOfDaysInMonth(monthAtStartOfWeek, isLeapYear: isLeapYear) as Int
            dayInMonthAtStartOfWeek = daysInPrevMonth + tempDayInMonth
        }
        
println("week started on : \(monthAtStartOfWeek)/\(dayInMonthAtStartOfWeek)/\(yearAtStartOfWeek)")
        //Set Up Request
        var request = NSFetchRequest(entityName: self.EntityName)
        
        //Set up predicates
        var predDrinkType = NSPredicate(format: "drinkType == %@", self.DrinkType)
        var predMonth = NSPredicate(format: "month >= %@", monthAtStartOfWeek as NSNumber)
        var predDay = NSPredicate(format: "dayAsInt >= %@", dayInMonthAtStartOfWeek as NSNumber)
        var predYear = NSPredicate(format: "year >= %@", yearAtStartOfWeek as NSNumber)
        var allPreds = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predDrinkType!, predMonth!, predDay!, predYear!])
        
        request.predicate = allPreds

        //Get Results
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            println("week counts \(results!.count) for \(self.DrinkType)")
            
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getDailyTotal()->Int {
        return 10
    }
    
    func getSessionTotal()->Int {
        return 1
    }
    
}