//
//  BeerClass.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/8/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation

class Beer:NSObject {
    
    private var allTotal = Int()
    private var yearTotal = Int()
    private var monthlyTotal = Int()
    private var weeklyTotal = Int()
    private var todayTotal = Int()
    private var sessionTotal = Int()
    
    private var drinkDAO = DrinkDAO(drinkType: "beer")
    
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
     * Takes in a Date dictionary and saves a beer event
     */
    func saveBeerEvent(dateDict: Dictionary<String, Any>) {
        drinkDAO.saveDrinkEvent(dateDict)
    }
    
    /**
     * Updates Beer total since tracking began
     */
    func updateAllTotal() {
        self.setAllTotal(drinkDAO.getAllTimeTotal())
    }
    
    /**
    * Updates Beer total for the year
    */
    func updateYearTotal() {
        self.setYearTotal(yearTotal + 60)
    }
    
    /**
    * Updates Beer total for the month
    */
    func updateMonthTotal() {
        self.setMonthlyTotal(monthlyTotal + 45)
    }
    
    /**
    * Updates Beer total for the week
    */
    func updateWeekTotal() {
        self.setWeeklyTotal(weeklyTotal + 30)
    }
    
    /**
    * Updates Beer total for today
    */
    func updateTodayTotal() {
        self.setTodayTotal(todayTotal + 15)
    }
    
    /**
    * Updates Beer total for this session
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
     * Returns Beer Object as Dictionary
     */
    func toDictionary()->Dictionary<String, Int> {
        var beerDict: Dictionary<String, Int> = Dictionary<String, Int>()
        
        beerDict["all"] = self.getAllTotal()
        beerDict["year"] = self.getYearTotal()
        beerDict["monthly"] = self.getMonthlyTotal()
        beerDict["weekly"] = self.getWeeklyTotal()
        beerDict["today"] = self.getTodayTotal()
        beerDict["session"] = self.getSessionTotal()
        
        return beerDict
    }
}