//
//  TimeKeeperClass.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation

class TimeKeeper: NSObject {
    
    private var SecsInHour: Double = 3600.00
    private var SecsInMinute: Double = 60.00
    private var dateObj = Dictionary<String, Any>()
    
    override init() {
        super.init()
    }
    
    /**
    * Returns a Dictionary object containing various date info
    */
    func getFormattedDate(dateAsString: String = "")->Dictionary<String, Any> {
        
        var date = NSDate()
        
        //Handles converting param time to NSDate
        if(dateAsString != "") {
            var dateFormatter: NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
            date = dateFormatter.dateFromString(dateAsString)!
        }
        
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
        let unixTime = date.timeIntervalSince1970

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
        dateObj["unixTime"] = unixTime
        
        return dateObj
    }
    
    func getCurrentDateAsString()-> String {
        if dateObj.isEmpty {
            self.getFormattedDate()
        }
        
        var month: String = String(stringInterpolationSegment: dateObj["month"]!)
        var day: String = String(stringInterpolationSegment: dateObj["dayAsInt"]!)
        var year: String = String(stringInterpolationSegment: dateObj["year"]!)
        
        var dateString =  month + "-" + day + "-" + year

        return dateString
    }
    
    //Send an hour, min, and sec and get total secs back
    func getNumberOfSecondsBasedOnTime(hour: Int, min: Int, sec: Int)->Double {
        var totalSecs: Double = 0.0

        //Convert hours to secs
        var hrSecs: Double = SecsInHour * Double(hour)
        
        //Convert mins to secs
        var minSecs: Double = SecsInMinute * Double(min)
        
        //Add all secs together for total
        totalSecs = hrSecs + minSecs + Double(sec)
        
        return totalSecs
    }
    
    // Lets you know if a year is a leap year
    func isLeapYear(iYear: Int)->Bool {
        
        if iYear % 4 == 0  {
         
            if iYear % 100 == 0 {
                
                if iYear % 400 == 0 {
                    return true
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    // Gets the number of days for a given month and accounts for leap year
    func getNumberOfDaysInMonth(iMonth: Int, isLeapYear: Bool)-> Int {
        var numOfDays: Int = 0
        
        switch(iMonth) {
        case 1:
            numOfDays = 31
            break
        case 2:
            numOfDays = 28
            break
        case 3:
            numOfDays = 31
            break
        case 4:
            numOfDays = 30
            break
        case 5:
            numOfDays = 31
            break
        case 6:
            numOfDays = 30
            break
        case 7:
            numOfDays = 31
            break
        case 8:
            numOfDays = 31
            break
        case 9:
            numOfDays = 30
            break
        case 10:
            numOfDays = 31
            break
        case 11:
            numOfDays = 30
            break
        case 12:
            numOfDays = 31
            break
        default:
            numOfDays = 30
            break
        }
        
        if isLeapYear && iMonth == 2{
            numOfDays = 29
        }
        
        return numOfDays
    }
}