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
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.pirateShips?.count)!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("shipCell")

        
        
        if let ships = self.pirateShips {
            let shipsAsArray = Array(ships)
            self.shipSelected = shipsAsArray[indexPath.row]
            cell?.textLabel?.text = shipsAsArray[indexPath.row].name
         //   cell?.detailTextLabel?.text = shipsAsArray[indexPath.row].engine.propulsionType
        }
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        let selectedPirateShips = self.dataStore.pirates[self.tableView.indexPathForSelectedRow!.row].ships
//        destinationVC?.pirateShips = selectedPirateShips
        
      //  let pirateShipsAsArray = Array(arrayLiteral: self.pirateShips)
        
        let destinationVC = segue.destinationViewController as? ShipDetailViewController

        destinationVC?.selectedShip = self.shipSelected

        }
}