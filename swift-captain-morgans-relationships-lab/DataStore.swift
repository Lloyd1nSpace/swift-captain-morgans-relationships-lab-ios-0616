//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Lloyd W. Sykes on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import CoreData

class DataStore: NSObject {
    
    static let sharedDataManager = DataStore()
    var pirates: [Pirate] = []
    var ships: [Ship] = []
    var engines: [Engine] = []
    
    func fetchData() {
        
        //        if self.pirates.count == 0 || self.ships.count == 0 || self.engines.count == 0 {
        //            generateTestData()
        //        }
        // Calling generateTestData() will put in fake information to ensure CoreData is working the way it's supposed to. The project is currently set up to receive custom information.
        
        var catchingError: NSError?
        
        let pirateRequest = NSFetchRequest(entityName: "Pirate")
        let shipRequest = NSFetchRequest(entityName: "Ship")
        let engineRequest = NSFetchRequest(entityName: "Engine")
        
        do {
            self.pirates = try self.managedObjectContext.executeFetchRequest(pirateRequest) as! [Pirate]
            self.ships = try self.managedObjectContext.executeFetchRequest(shipRequest) as! [Ship]
            self.engines = try self.managedObjectContext.executeFetchRequest(engineRequest) as! [Engine]
        } catch let randomeError as NSError {
            self.pirates = []
            self.ships = []
            self.engines = []
            catchingError = randomeError
            print(catchingError)
            abort()
        }
    }
    
    func generateTestData() {
        testData()
    }
    
    func testData() {
        let pirate1 = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: self.managedObjectContext) as! Pirate
        pirate1.name = "Johnny Thunder"
        
        let pirate2 = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: self.managedObjectContext) as! Pirate
        pirate2.name = "Henry Thunderbluss"
        
        let pirate3 = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: self.managedObjectContext) as! Pirate
        pirate3.name = "Mark Monkeyface"
        
        let pirate4 = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: self.managedObjectContext) as! Pirate
        pirate4.name = "Captain Jack"
        
        let ship1 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship1.name = "La Amistad"
        ship1.pirate = pirate1
        
        let ship2 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship2.name = "City of Norfolk"
        ship2.pirate = pirate1
        
        let ship3 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship3.name = "Hannibal"
        ship3.pirate = pirate2
        
        let ship4 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship4.name = "Hope"
        ship4.pirate = pirate2
        
        let ship5 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship5.name = "Lord Ligonier"
        ship5.pirate = pirate3
        
        let ship6 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship6.name = "Wanderer"
        ship6.pirate = pirate3
        
        let ship7 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship7.name = "Nightingale"
        ship7.pirate = pirate4
        
        let ship8 = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: self.managedObjectContext) as! Ship
        ship8.name = "Manuela"
        ship8.pirate = pirate4
        
        let engine1 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine1.propulsionType = "Sail"
        engine1.ship = ship1
        
        let engine2 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine2.propulsionType = "Gas"
        engine2.ship = ship2
        
        let engine3 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine3.propulsionType = "Electric"
        engine3.ship = ship3
        
        let engine4 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine4.propulsionType = "Sail"
        engine4.ship = ship4
        
        let engine5 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine5.propulsionType = "Sail"
        engine5.ship = ship5
        
        let engine6 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine6.propulsionType = "Gas"
        engine6.ship = ship6
        
        let engine7 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine7.propulsionType = "Electric"
        engine7.ship = ship7
        
        let engine8 = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: self.managedObjectContext) as! Engine
        engine8.propulsionType = "Sail"
        engine8.ship = ship8
    }
    
    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    var managedObjectContext: NSManagedObjectContext
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("captainMorgan", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("captainMorgan.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
