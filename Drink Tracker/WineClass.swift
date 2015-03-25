//
//  WineClass.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/9/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation

class Wine:NSObject {
    
    private var allTotal = Int()
    private var yearTotal = Int()
    private var monthlyTotal = Int()
    private var weeklyTotal = Int()
    private var todayTotal = Int()
    private var sessionTotal = Int()
    
    private var drinkDAO = DrinkDAO(drinkType: "wine")
    
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
     * Save a Wine Event
     */
    func saveWineEvent(dateDict: Dictionary<String, Any>) {
        drinkDAO.saveDrinkEvent(dateDict)
    }

    /**
    * Updates Wine total since tracking began
    */
    func updateAllTotal() {
        self.setAllTotal(drinkDAO.getAllTimeTotal())
    }
    
    /**
    * Updates Wine total for the year
    */
    func updateYearTotal() {
        self.setYearTotal(drinkDAO.getYearlyTotal())
    }
    
    /**
    * Updates Wine total for the month
    */
    func updateMonthTotal() {
        self.setMonthlyTotal(drinkDAO.getMonthlyTotal())
    }
    
    /**
    * Updates Wine total for the week
    */
    func updateWeekTotal() {
        self.setWeeklyTotal(drinkDAO.getWeeklyTotal())
    }
    
    /**
    * Updates Wine total for today
    */
    func updateTodayTotal() {
        self.setTodayTotal(drinkDAO.getDailyTotal())
    }
    
    /**
    * Updates Wine total for this session
    */
    func updateSessionTotal() {
        self.setSessionTotal(drinkDAO.getSessionTotal())
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
    * Returns Beer Object as Dictionary
    */
    func toDictionary()->Dictionary<String, Int> {
        var wineDict: Dictionary<String, Int> = Dictionary<String, Int>()
        
        wineDict["all"] = self.getAllTotal()
        wineDict["year"] = self.getYearTotal()
        wineDict["monthly"] = self.getMonthlyTotal()
        wineDict["weekly"] = self.getWeeklyTotal()
        wineDict["today"] = self.getTodayTotal()
        wineDict["session"] = self.getSessionTotal()
        
        return wineDict
    }
}