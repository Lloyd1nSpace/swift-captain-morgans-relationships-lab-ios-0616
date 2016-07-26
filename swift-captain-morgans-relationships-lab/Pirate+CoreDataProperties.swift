//
//  Pirate+CoreDataProperties.swift
//  
//
//  Created by Lloyd W. Sykes on 7/25/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Pirate {

    @NSManaged var name: String!
    @NSManaged var ships: Set<Ship>

}
