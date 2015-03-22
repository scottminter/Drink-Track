//
//  DrinkEvents.swift
//  Drink Tracker
//
//  Created by Scott Minter on 3/22/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import CoreData

class DrinkEvents: NSManagedObject {

    @NSManaged var dayAsInt: NSNumber
    @NSManaged var dayAsString: String
    @NSManaged var drinkType: String
    @NSManaged var hour: NSNumber
    @NSManaged var minute: NSNumber
    @NSManaged var month: NSNumber
    @NSManaged var second: NSNumber
    @NSManaged var weekInMonth: NSNumber
    @NSManaged var year: NSNumber

    convenience init(dayInt: NSNumber, dayStr: String, drnkTyp: String, hr: NSNumber, min: NSNumber, mnth: NSNumber, sec: NSNumber, wkInMnth: NSNumber, yr: NSNumber, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {

        println("***** IM GETTING CALLED *****")
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.dayAsInt = dayInt
        self.dayAsString = dayStr
        self.drinkType = drnkTyp
        self.hour = hr
        self.minute = min
        self.month = mnth
        self.second = sec
        self.weekInMonth = wkInMnth
        self.year = yr
    }
}
/*

class Alternative: NSManagedObject {
    @NSManaged var text: String
    @NSManaged var isCorrect: Bool
    @NSManaged var image: NSData
}

convenience init(text: String, isCorrect: Bool, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
    self.init(entity: entity, insertIntoManagedObjectContext: context)
    self.text = text
    self.isCorrect = isCorrect
}
*/