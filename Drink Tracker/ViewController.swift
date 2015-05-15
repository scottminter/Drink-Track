//
//  ViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 2/21/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var infoButton: UIButton!
    
    //Upper Left Button
    @IBOutlet weak var ULButton: UIButton!
    @IBOutlet weak var ULView: UIView!
    
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var wineCountLabel: UILabel!
    @IBOutlet weak var shotCountLabel: UILabel!
    @IBOutlet weak var mixerCountLabel: UILabel!
    @IBOutlet weak var drinkCountLabel: UILabel!
    
    let TimeKeeperObj = TimeKeeper()
    let BeerObj = DrinkClass(dt: "beer")
    let WineObj = DrinkClass(dt: "wine")
    let ShotObj = DrinkClass(dt: "shot")
    let MixerObj = DrinkClass(dt: "mixer")
    
    /*
     * Drink Buttons Action
     */
    @IBAction func drinkSelected(sender: AnyObject) {
        var buttonId = sender.restorationIdentifier!!
        var selectedDrinkCount: Int = 0
        
        let dateDict = TimeKeeperObj.getFormattedDate()
        
        if buttonId == "beer" {
            BeerObj.saveDrinkEvent(dateDict)
            selectedDrinkCount = BeerObj.getSessionTotal()
        }
        else if buttonId == "wine" {
            WineObj.saveDrinkEvent(dateDict)
            selectedDrinkCount = WineObj.getSessionTotal()
        }
        else if buttonId == "shot" {
            ShotObj.saveDrinkEvent(dateDict)
            selectedDrinkCount = ShotObj.getSessionTotal()
        }
        else if buttonId == "mixer" {
            MixerObj.saveDrinkEvent(dateDict)
            selectedDrinkCount = MixerObj.getSessionTotal()
        }
        
        /**
         * TODO: Find a better way to capitalize the first letter
         */
        var cnt = 0
        var capitalizedButtonId = String()
        for i: Character in buttonId {
            if cnt == 0 {
                capitalizedButtonId += String(i).capitalizedString
            }
            else {
                capitalizedButtonId += String(i)
            }
            cnt++
        }
        
        //Add the s if the count is more than 1
        if selectedDrinkCount == 1 {
            drinkCountLabel.text = "\(selectedDrinkCount) \(capitalizedButtonId)"
        }
        else {
            drinkCountLabel.text = "\(selectedDrinkCount) \(capitalizedButtonId)s"
        }

        //Fade-In the drink total label
        drinkCountLabel.fadeIn()
        
        //Fade-Out the drink total label
        drinkCountLabel.fadeOut()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //println(segue.identifier)
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the transparensy level for the drink count label
        drinkCountLabel.alpha = 0.0
        drinkCountLabel.layer.cornerRadius = 10
        drinkCountLabel.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {}
}

