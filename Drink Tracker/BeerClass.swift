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
    private var lastSessionTotal = Int()
    
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
        lastSessionTotal = 0
        
        self.setAllTotalAtSameTime()
    }
    
    /**
     * Takes in a Date dictionary and saves a beer event
     */
    func saveBeerEvent(dateDict: Dictionary<String, Any>) {
        drinkDAO.saveDrinkEvent(dateDict)
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
        beerDict["lastSession"] = self.getLastSessionTotal()
        
        return beerDict
    }
}