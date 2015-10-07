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
    
    let TimeKeeperObj = TimeKeeper()
    let BeerObj = DrinkClass(dt: "beer")
    let WineObj = DrinkClass(dt: "wine")
    let ShotObj = DrinkClass(dt: "shot")
    let MixerObj = DrinkClass(dt: "mixer")
    
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var wineLabel: UILabel!
    @IBOutlet weak var shotLabel: UILabel!
    @IBOutlet weak var mixerLabel: UILabel!
    
    /*
     * Drink Buttons Action
     */
    @IBAction func drinkSelected(sender: AnyObject) {
        let buttonId = sender.restorationIdentifier!!
        var selectedDrinkCount: Int = 0
        
        let dateDict = TimeKeeperObj.getFormattedDate()
        
        if buttonId == "beer" {
            BeerObj.saveDrinkEvent(dateDict)
            self.beerLabel.text = String(BeerObj.getSessionTotal())
        }
        else if buttonId == "wine" {
            WineObj.saveDrinkEvent(dateDict)
            self.wineLabel.text = String(WineObj.getSessionTotal())
        }
        else if buttonId == "shot" {
            ShotObj.saveDrinkEvent(dateDict)
            self.shotLabel.text = String(ShotObj.getSessionTotal())
        }
        else if buttonId == "mixer" {
            MixerObj.saveDrinkEvent(dateDict)
            self.mixerLabel.text = String(MixerObj.getSessionTotal())
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //println(segue.identifier)
    }
    
    //Disables Portrait
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    func updateAllSession() {
        //Set the labels to the current session count
        self.beerLabel.text = String(self.BeerObj.getSessionTotal())
        self.wineLabel.text = String(self.WineObj.getSessionTotal())
        self.shotLabel.text = String(self.ShotObj.getSessionTotal())
        self.mixerLabel.text = String(self.MixerObj.getSessionTotal())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateAllSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.updateAllSession()
    }
}

