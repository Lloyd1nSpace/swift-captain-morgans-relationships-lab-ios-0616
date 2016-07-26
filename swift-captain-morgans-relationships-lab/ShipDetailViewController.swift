//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class ShipDetailViewController: UIViewController {
    
    let dataStore = DataStore.sharedDataManager
    var selectedShip: Ship?
    
    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.shipNameLabel.text = "Ship Name: \(self.selectedShip!.name)"
            self.pirateNameLabel.text = "Pirate Name: \(self.selectedShip!.pirate.name)"
           // self.propulsionTypeLabel.text = "Propulsion Type: \(self.selectedShip!.engine.propulsionType)"
    }
}
