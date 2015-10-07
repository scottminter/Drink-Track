//
//  AdjustTotalsViewController.swift
//  Drink Tracker
//
//  Created by Scott Minter on 5/12/15.
//  Copyright (c) 2015 Scott Minter Designs. All rights reserved.
//

import Foundation
import UIKit

class AdjustTotalsViewController: UIViewController {
    
    let TimeKeeperObj = TimeKeeper()
    let BeerObj = DrinkClass(dt: "beer")
    let WineObj = DrinkClass(dt: "wine")
    let ShotObj = DrinkClass(dt: "shot")
    let MixerObj = DrinkClass(dt: "mixer")
    
    @IBOutlet weak var beerCountLabel: UILabel!
    @IBOutlet weak var wineCountLabel: UILabel!
    @IBOutlet weak var shotCountLabel: UILabel!
    @IBOutlet weak var mixerCountLabel: UILabel!
    
    
    // Handles adding a new drink event
    @IBAction func addDrinkEvent(sender: AnyObject) {
        let buttonId = sender.restorationIdentifier!!
        //var selectedDrinkCount: Int = 0
        
        let dateDict = TimeKeeperObj.getFormattedDate()
        
        if buttonId == "beerAdd" {
            BeerObj.saveDrinkEvent(dateDict)
            self.beerCountLabel.text = String(BeerObj.getAllTotal())
        }
        else if buttonId == "wineAdd" {
            WineObj.saveDrinkEvent(dateDict)
            self.wineCountLabel.text = String(WineObj.getAllTotal())
        }
        else if buttonId == "shotAdd" {
            self.ShotObj.saveDrinkEvent(dateDict)
            self.shotCountLabel.text = String(self.ShotObj.getAllTotal())
        }
        else if buttonId == "mixerAdd" {
            self.MixerObj.saveDrinkEvent(dateDict)
            self.mixerCountLabel.text = String(self.MixerObj.getAllTotal())
        }
        
    }
    
    // Removes a drink event
    @IBAction func removeDrinkEvent(sender: AnyObject) {
        let buttonId = sender.restorationIdentifier!!
        //var selectedDrinkCount: Int = 0
        
        //let dateDict = TimeKeeperObj.getFormattedDate()
        
        if buttonId == "beerRemove" {
            self.BeerObj.deleteMostRecentDrinkEvent()
            self.beerCountLabel.text = String(self.BeerObj.getAllTotal())
        }
        else if buttonId == "wineRemove" {
            self.WineObj.deleteMostRecentDrinkEvent()
            self.wineCountLabel.text = String(self.WineObj.getAllTotal())
        }
        else if buttonId == "shotRemove" {
            self.ShotObj.deleteMostRecentDrinkEvent()
            self.shotCountLabel.text = String(self.ShotObj.getAllTotal())
        }
        else if buttonId == "mixerRemove" {
            self.MixerObj.deleteMostRecentDrinkEvent()
            self.mixerCountLabel.text = String(self.MixerObj.getAllTotal())
        }
        
    }

    @IBAction func backButtonAction(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: {});//This is intended to dismiss the Info sceen.
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    func updateAll() {
        self.beerCountLabel.text = String(self.BeerObj.getAllTotal())
        self.wineCountLabel.text = String(self.WineObj.getAllTotal())
        self.shotCountLabel.text = String(self.ShotObj.getAllTotal())
        self.mixerCountLabel.text = String(self.MixerObj.getAllTotal())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
}