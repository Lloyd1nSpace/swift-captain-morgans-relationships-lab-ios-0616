//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class PiratesTableViewController: UITableViewController {
    
    let dataStore = DataStore.sharedDataManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.dataStore.fetchData()
        self.tableView.reloadData()
        // Ensures the PiratesTableViewController is refreshed with new data if a new Pirate is added.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStore.pirates.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("pirateCell")
        
        cell?.textLabel?.text = self.dataStore.pirates[indexPath.row].name
        cell?.detailTextLabel?.text = String(self.dataStore.pirates[indexPath.row].ships.count)
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "shipsSegue" {
            let destinationVC = segue.destinationViewController as? ShipsTableViewController
            let selectedPirateShips = self.dataStore.pirates[self.tableView.indexPathForSelectedRow!.row].ships
            destinationVC?.pirateShips = selectedPirateShips
            // This is ensuring we're associating the correct ships with the correct Pirate & passes it to the ShipsTableViewController
            destinationVC!.pirate = self.dataStore.pirates[self.tableView.indexPathForSelectedRow!.row]
        } else if segue.identifier == "addPirate" {
            let destinationVC = segue.destinationViewController as? AddPirateViewController
        }
    }
}