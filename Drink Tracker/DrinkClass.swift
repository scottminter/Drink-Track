//
//  DrinkClass.swift
//  Drink Tracker
//
//  Created by Scott Minter on 4/7/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation

class DrinkClass: NSObject {
    //Type of drink the object is for: beer, wine, mixer, shot
    private var drinkType = String()
    
    //All time total based on drink type
    private var allTotal = Int()
    
    //This years total based on drink type
    private var yearTotal = Int()
    
    //This months total based on drink type
    private var monthlyTotal = Int()
    
    //This weeks total based on drink type
    private var weeklyTotal = Int()
    
    //Todays total based on drink type
    private var todayTotal = Int()
    
    //This session's total based on drink type
    private var sessionTotal = Int()
    
    //Last sessions total based on drink type
    private var lastSessionTotal = Int()
    
    //Data Access Object for Drink Types
    private var drinkDAO = DrinkDAO()
    
    //Time Keeper instance
    private var timeKeeper = TimeKeeper()
    
    override init() {
        super.init()
    }
    
    /**
    * Constructor
    *
    * Takes in a drink type and sets up the object.
    */
    init(dt: String) {
        
        super.init()
        
        switch dt {
        case "beer":
            self.drinkType = "beer"
            break
        case "wine":
            self.drinkType = "wine"
            break
        case "shot":
            self.drinkType = "shot"
            break
        case "mixer":
            self.drinkType = "mixer"
            break
        default:
            self.drinkType = "beer"
            break
        }
        
        self.drinkDAO = DrinkDAO(drinkType: drinkType)
        allTotal = 0
        yearTotal = 0
        monthlyTotal = 0
        weeklyTotal = 0
        todayTotal = 0
        sessionTotal = 0
        lastSessionTotal = 0
        
        //self.setAllTotalAtSameTime()
    }
    
    /**
     * Gets totals over a date range
     */
    func getTotalByDates(startDate: String, endDate: String)->Int {

        let startWithTime: String = startDate + " 00:00:00"
        let endWithTime: String = endDate + " 23:59:59"

       let startDateDict: Dictionary<String, Any> = self.timeKeeper.getFormattedDate(startWithTime)

        let endDateDict: Dictionary<String, Any> = self.timeKeeper.getFormattedDate(endWithTime)
        
        let total: Int = self.drinkDAO.getTotalByDates(startDt: startDateDict, endDt: endDateDict)
        
        return total
    }
    
    /**
     * Takes in a Date dictionary and saves a drink event
     */
    func saveDrinkEvent(dateDict: Dictionary<String, Any>) {
        drinkDAO.saveDrinkEvent(dateDict)
    }
    
    /**
     * Deletes the most recent drink event
     */
    func deleteMostRecentDrinkEvent() {
        self.drinkDAO.deleteMostRecentEvent()
    }
    
    /**
     * Sets all priv mbr data at same time
     */
    func setAllTotalAtSameTime() {
        self.setAllTotal(drinkDAO.getAllTimeTotal())
        self.setYearTotal(drinkDAO.getYearlyTotal())
        self.setMonthlyTotal(drinkDAO.getMonthlyTotal())
        self.setWeeklyTotal(drinkDAO.getWeeklyTotal())
        self.setTodayTotal(drinkDAO.getDailyTotal())
        self.setSessionTotal(drinkDAO.getSessionTotal())
        self.setLastSessionTotal(drinkDAO.getLastSessionTotal())
    }
    
    /**
     * Setter for All Total
     */
    func setAllTotal(allTot: Int) {
        allTotal = allTot
    }
    
    /**
     * Getter for All Total
     */
    func getAllTotal()->Int {
        self.setAllTotal(drinkDAO.getAllTimeTotal())
        
        return allTotal
    }
    
    /**
     * Setter for Year Total
     */
    func setYearTotal(yearTot: Int) {
        yearTotal = yearTot
    }
    
    /**
     * Getter for the Year Total
     */
    func getYearTotal()->Int {
        self.setYearTotal(drinkDAO.getYearlyTotal())
        
        return yearTotal
    }
    
    /**
     * Setter for the Monthly Total
     */
    func setMonthlyTotal(monthTot: Int) {
        monthlyTotal = monthTot
    }
    
    /**
     * Getter for the Monthly Total
     */
    func getMonthlyTotal()->Int {
        self.setMonthlyTotal(drinkDAO.getMonthlyTotal())
        
        return monthlyTotal
    }
    
    /**
     * Setter for Weekly Total
     */
    func setWeeklyTotal(weekTot: Int) {
        weeklyTotal = weekTot
    }
    
    /**
     * Getter for Weekly Total
     */
    func getWeeklyTotal()->Int {
        self.setWeeklyTotal(drinkDAO.getWeeklyTotal())
        
        return weeklyTotal
    }
    
    /**
     * Setter for Today Total
     */
    func setTodayTotal(todayTot: Int) {
        todayTotal = todayTot
    }
    
    /**
     * Getter for Today Total
     */
    func getTodayTotal()->Int {
        self.setTodayTotal(drinkDAO.getDailyTotal())
        
        return todayTotal
    }
    
    /**
     * Setter for Session Total
     */
    func setSessionTotal(sessionTot: Int) {
        sessionTotal = sessionTot
    }
    
    /**
     * Getter for Session Total
     */
    func getSessionTotal()->Int {
        self.setSessionTotal(drinkDAO.getSessionTotal())
        
        return sessionTotal
    }
    
    /**
     * Setter for last Session total
     */
    func setLastSessionTotal(lastSessTot: Int) {
        lastSessionTotal = lastSessTot
    }
    
    /**
     *  Setter for last Session total
     */
    func getLastSessionTotal()->Int {
        self.setLastSessionTotal(drinkDAO.getLastSessionTotal())
        
        return lastSessionTotal
    }
    
    /**
     * Returns Drink Object as Dictionary
     */
    func toDictionary()->Dictionary<String, Int> {
        var drinkDict: Dictionary<String, Int> = Dictionary<String, Int>()
        
        drinkDict["all"] = self.getAllTotal()
        drinkDict["year"] = self.getYearTotal()
        drinkDict["monthly"] = self.getMonthlyTotal()
        drinkDict["weekly"] = self.getWeeklyTotal()
        drinkDict["today"] = self.getTodayTotal()
        drinkDict["session"] = self.getSessionTotal()
        drinkDict["lastSession"] = self.getLastSessionTotal()
        
        return drinkDict
    }
}