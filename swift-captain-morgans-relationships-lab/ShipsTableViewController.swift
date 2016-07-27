//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class ShipsTableViewController: UITableViewController {
    
    let dataStore = DataStore.sharedDataManager
    var pirateShips: Set<Ship>?
    var shipSelected: Ship?
    var pirate: Pirate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dataStore.fetchData()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.pirateShips?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("shipCell")
        
        if let ships = self.pirateShips {
            let shipsAsArray = Array(ships)
            // Had to cast the Set<Ship> into Array in order to subscript the [indexPath.row]
            self.shipSelected = shipsAsArray[indexPath.row]
            cell?.textLabel?.text = shipsAsArray[indexPath.row].name
            cell?.detailTextLabel?.text = shipsAsArray[indexPath.row].engine.propulsionType
        }
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shipDetailSegue" {
            let destinationVC = segue.destinationViewController as! ShipDetailViewController
            let currentShip = self.tableView.indexPathForSelectedRow?.row
            if let currentShip = currentShip  {
                if let ships = self.pirateShips {
                    let shipsAsArray = Array(ships)
                    destinationVC.selectedShip = shipsAsArray[currentShip]
                }
            }
        } else if segue.identifier == "addShip" {
            let destinationVC = segue.destinationViewController as! AddShipViewController
            destinationVC.pirate = self.pirate
            // This associates the correct pirate with the ship when adding a ship in the AddShipViewController
        }
    }
}