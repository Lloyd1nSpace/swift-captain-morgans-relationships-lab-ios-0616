//
//  AddShipViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddShipViewController: UIViewController {
    
    let dataStore = DataStore.sharedDataManager
    var pirate: Pirate?
    
    @IBOutlet weak var addShipTextField: UITextField!
    @IBOutlet weak var engineTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let newEngine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.dataStore.managedObjectContext) as! Engine
        newEngine.propulsionType = self.engineTextField.text!
    
        let newShip = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.dataStore.managedObjectContext) as! Ship
        newShip.name = self.addShipTextField.text
        newShip.pirate = self.pirate
        newShip.engine = newEngine
        
        self.dataStore.saveContext()
        self.dataStore.fetchData()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}