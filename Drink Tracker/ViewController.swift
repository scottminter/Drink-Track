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
    let BeerObj = Beer()
    let WineObj = Wine()
    let ShotObj = Shot()
    let MixerObj = Mixer()
    
    /*
     * Drink Buttons Action
     */
    @IBAction func drinkSelected(sender: AnyObject) {
        var buttonId = sender.restorationIdentifier!!
        var selectedDrinkCount: Int = 0
        
        let dateDict = TimeKeeperObj.getFormattedDate()
        
        if buttonId == "beer" {
            BeerObj.saveBeerEvent(dateDict)
            selectedDrinkCount = BeerObj.getSessionTotal()
        }
        else if buttonId == "wine" {
            WineObj.saveWineEvent(dateDict)
            selectedDrinkCount = WineObj.getSessionTotal()
        }
        else if buttonId == "shot" {
            ShotObj.saveShotEvent(dateDict)
            selectedDrinkCount = ShotObj.getSessionTotal()
        }
        else if buttonId == "mixer" {
            MixerObj.saveMixerEvent(dateDict)
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
        
        drinkCountLabel.fadeIn()
        //drinkCountLabel.alpha = 1.0
        drinkCountLabel.fadeOut()
    }
    
    func whichView() {
        println("Tracking View")
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        drinkCountLabel.alpha = 0.0
        
//        BeerObj.getAllTotal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        whichView()
    }
}

