//
//  ShotClass.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/9/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation

class Shot:NSObject {
    
    private var allTotal = Int()
    private var yearTotal = Int()
    private var monthlyTotal = Int()
    private var weeklyTotal = Int()
    private var todayTotal = Int()
    private var sessionTotal = Int()
    
    private var drinkDAO = DrinkDAO(drinkType: "shot")
    
    /**
    * Default Constructor
    */
    override init() {
        
        super.init()
        
        allTotal = 0
        yearTotal = 0
        monthlyTotal = 0
        weeklyTotal = 0
        todayTotal = 0
        sessionTotal = 0
        
        self.updateTotals()
    }
    
    /**
    * Takes in a Date dictionary and saves a Shot event
    */
    func saveShotEvent(dateDict: Dictionary<String, Any>) {
        drinkDAO.saveDrinkEvent(dateDict)
    }
    
    /**
    * Updates Shot total since tracking began
    */
    func updateAllTotal() {
        //self.setAllTotal(allTotal + 75)
        self.setAllTotal(drinkDAO.getAllTimeTotal())        
    }
    
    /**
    * Updates Shot total for the year
    */
    func updateYearTotal() {
        self.setYearTotal(yearTotal + 60)
    }
    
    /**
    * Updates Shot total for the month
    */
    func updateMonthTotal() {
        self.setMonthlyTotal(monthlyTotal + 45)
    }
    
    /**
    * Updates Shot total for the week
    */
    func updateWeekTotal() {
        self.setWeeklyTotal(weeklyTotal + 30)
    }
    
    /**
    * Updates Shot total for today
    */
    func updateTodayTotal() {
        self.setTodayTotal(todayTotal + 15)
    }
    
    /**
    * Updates Shot total for this session
    */
    func updateSessionTotal() {
        self.setSessionTotal(sessionTotal + 5)
    }
    
    /**
    * Executes all the update statements
    */
    func updateTotals() {
        self.updateAllTotal()
        self.updateYearTotal()
        self.updateMonthTotal()
        self.updateWeekTotal()
        self.updateTodayTotal()
        self.updateSessionTotal()
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
        return sessionTotal
    }
    
    /**
    * Returns Shot Object as Dictionary
    */
    func toDictionary()->Dictionary<String, Int> {
        var shotDict: Dictionary<String, Int> = Dictionary<String, Int>()
        
        shotDict["all"] = self.getAllTotal()
        shotDict["year"] = self.getYearTotal()
        shotDict["monthly"] = self.getMonthlyTotal()
        shotDict["weekly"] = self.getWeeklyTotal()
        shotDict["today"] = self.getTodayTotal()
        shotDict["session"] = self.getSessionTotal()
        
        return shotDict
    }
}