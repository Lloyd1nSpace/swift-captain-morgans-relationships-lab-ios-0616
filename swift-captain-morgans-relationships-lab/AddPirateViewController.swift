//
//  AddPirateViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddPirateViewController: UIViewController {
    
    let dataStore = DataStore.sharedDataManager
    
    @IBOutlet weak var pirateNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let newPirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: self.dataStore.managedObjectContext) as! Pirate
        newPirate.name = self.pirateNameTextField.text
        self.dismissViewControllerAnimated(true, completion: nil)
        self.dataStore.saveContext()
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}