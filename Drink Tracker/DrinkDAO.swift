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
        var unixTime: Double = (dateDict["unixTime"] != nil ? dateDict["unixTime"] : 0.0) as Double
        
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
        newDrinkEvent.setValue(unixTime, forKey: "unixTime")
        
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
//currentYear = 2016
        
        var tempDayInMonth: Int = currentDayInMonth as Int
        
        //TODO: Move this to Time keeper as a method
        
        //Count back to beginning of week
        for var i: Int = currentDayOfWeek as Int; i > 1; i-- {
            tempDayInMonth--
        }
        
        //Month at start of week
        var monthAtStartOfWeek: Int = currentMonth as Int
        //Day in month on Sunday of current week
        var dayInMonthAtStartOfWeek = tempDayInMonth
        //Year at Beginning of Week
        var yearAtStartOfWeek: Int = currentYear as Int
        
        //If this is less than 0 it means we went back a month
        if tempDayInMonth <= 0 {
            //account for beginning of the year
            if monthAtStartOfWeek != 1 {
                monthAtStartOfWeek--
            }
            else {
                monthAtStartOfWeek = 12
                
                //back year off by 1 because it's January
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
        //Get formatted date dictionary
        var dateDict: Dictionary = TimeObj.getFormattedDate()
        
        var currDay: NSNumber = ((dateDict["dayAsInt"] != nil) ? dateDict["dayAsInt"]! : 0) as NSNumber
        var currMonth: NSNumber = ((dateDict["month"] != nil) ? dateDict["month"]! : 0) as NSNumber
        var currYear: NSNumber = ((dateDict["year"] != nil) ? dateDict["year"]! : 0) as NSNumber
        
        var request = NSFetchRequest(entityName: self.EntityName)
        
        var predDrinkType = NSPredicate(format: "drinkType == %@", self.DrinkType)
        var predDay = NSPredicate(format: "dayAsInt == %@", currDay)
        var predMonth = NSPredicate(format: "month == %@", currMonth)
        var predYear = NSPredicate(format: "year == %@", currYear)
        var allPreds = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [predDrinkType!, predDay!, predMonth!, predYear!])
        
        request.predicate = allPreds
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results != nil {
            return results!.count
        }
        else {
            return 0
        }
    }
    
    func getSessionTotal()->Int {
println("\n*** Session Work ***")
        //Get formatted date
        var dateDict: Dictionary = TimeObj.getFormattedDate()
println(dateDict)
        
        var currDay: Int = ((dateDict["dayAsInt"] != nil) ? dateDict["dayAsInt"] : 0) as Int
        var currMonth: Int = ((dateDict["month"] != nil) ? dateDict["month"] : 0) as Int
        var currYear: Int = ((dateDict["year"] != nil) ? dateDict["year"] : 0) as Int
        var currHour: Int = ((dateDict["hour"] != nil) ? dateDict["hour"] : 0) as Int
        var currMin: Int = ((dateDict["minute"] != nil) ? dateDict["minute"] : 0) as Int
        var currSec: Int = ((dateDict["seconds"] != nil) ? dateDict["seconds"] : 0) as Int
/*
currDay = 1
currMonth = 1
currHour = 0
currYear = 2000
*/
        //Get Session Start Date Obj
        var sessStartDict: Dictionary = getStartDateTimeOfSession(currHour, date: currDay, month: currMonth, year: currYear)

        let startYear: String = String(sessStartDict["yearAtStart"]!)
        let startMonth: String = (sessStartDict["monthAtStart"]! < 10) ? "0" + String(sessStartDict["monthAtStart"]!) : String(sessStartDict["monthAtStart"]!)
        let startDate: String = (sessStartDict["dateAtStart"]! < 10) ? "0" + String(sessStartDict["dateAtStart"]!) : String(sessStartDict["dateAtStart"]!)
        let startHour: String = (sessStartDict["hourAtStart"]! < 10) ? "0" + String(sessStartDict["hourAtStart"]!) : String(sessStartDict["hourAtStart"]!)
        let startMin: String = (currMin < 10) ? "0" + String(currMin) : String(currMin)
        let startSec: String = (currSec < 10) ? "0" + String(currSec) : String(currSec)
        
        //Make Time String
        let dateAsString: String = "\(startYear)-\(startMonth)-\(startDate) \(startHour):\(startMin):\(startSec)"
println(dateAsString)
        
        //Create Unix TimeStamp of session start date
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-d HH:mm:SS"
        formatter.timeZone = NSTimeZone(name: NSTimeZone.localTimeZone().name)
        let dateObj = formatter.dateFromString(dateAsString)
        let startUnix: NSNumber = dateObj!.timeIntervalSince1970 as NSNumber
println(startUnix)
        
        var request = NSFetchRequest(entityName: self.EntityName)
        
        var drinkTypePred = NSPredicate(format: "drinkType == %@", self.DrinkType)
        var sessPred = NSPredicate(format: "unixTime >= %@", startUnix)
        var sortDesc = NSSortDescriptor(key: "unixTime", ascending: true)
        var allPreds = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [drinkTypePred!, sessPred!])
        
        request.predicate = allPreds
        request.sortDescriptors = [sortDesc]
        
        var results = context.executeFetchRequest(request, error: nil)
/*
        for var i = 0; i < results!.count; i++ {
            println(results![i].valueForKey("unixTime")!)
        }
*/
        if results != nil {
            var low: Double = results![0].valueForKey("unixTime") as Double
            println("last unix: \(low)")
        }
        else {
            println("Seomthing went wrong")
        }
        
        return 1
    }
    
    
    func getStartDateTimeOfSession(hour: Int, date: Int, month: Int, year: Int)->Dictionary<String, Int> {
        var sessionTimeDefinition = 2
        var results = Dictionary<String, Int>()
        
        //Find out if it's a leap year
        var isLeapYear: Bool = TimeObj.isLeapYear(year as Int)
        
        //Variables for the time at start of session
        var hourAtStartOfSession: Int = hour
        var dateAtStartOfSession: Int = date
        var monthAtStartOfSession: Int = month
        var yearAtStartOfSession: Int = year
        
        //1 Go back 3 hours
        var tempHour: Int = hourAtStartOfSession
        tempHour = tempHour - sessionTimeDefinition
        println("temp hour: \(tempHour)")
        if tempHour < 0 {
            hourAtStartOfSession = 24 + tempHour
            
            var tempDate: Int = dateAtStartOfSession as Int
            tempDate = tempDate - 1
            println("temp date: \(tempDate)")
            if tempDate <= 0 {
                var prevMonth: Int = monthAtStartOfSession as Int
                prevMonth--
                println("prev month: \(prevMonth)")
                
                if prevMonth <= 0 {
                    monthAtStartOfSession = 12
                    
                    yearAtStartOfSession--
                }
                else {
                    monthAtStartOfSession = prevMonth
                }
                
                //Date is end of previous month
                dateAtStartOfSession = TimeObj.getNumberOfDaysInMonth(monthAtStartOfSession, isLeapYear: isLeapYear)
            }
            else {
                dateAtStartOfSession = tempDate
            }
        }
        else {
            hourAtStartOfSession = tempHour
        }

        
        results["hourAtStart"] = hourAtStartOfSession
        results["monthAtStart"] = monthAtStartOfSession
        results["dateAtStart"] = dateAtStartOfSession
        results["yearAtStart"] = yearAtStartOfSession
        
        return results
        
    }
    
}