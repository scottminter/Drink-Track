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
    
    private var DrinkType = String()
    
    override init() {
        super.init()
        
    }
    
    init(drinkType: String) {
        DrinkType = drinkType
        
        println("DAO Instantiated for \(DrinkType)")
    }
    
    func saveDrinkEvent(dateDict: Dictionary<String, Any>)->Bool {
        
        println("DrinkDAO Saving for \(DrinkType) on \(dateDict)")
        
        return true
    }
    
    func getAllTimeTotal()->Int {
        return 200
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