//
//  CoreDataHelper.swift
//  easyshoot
//
//  Created by Andy Kim on 16/6/18.
//  Copyright © 2018 Robin Garnham. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// MARK: - Retrieve Objects

func searchObjectForEntity (entityName:String, context:NSManagedObjectContext, predicate:NSPredicate? = nil, sortKey:String? = nil, sortAscending:Bool = false) -> [NSManagedObject] {
    // get fetch request
    let request = NSFetchRequest<NSFetchRequestResult>()
    // get entity description for entity name and context
    let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
    
    // set fetch request with entity description
    request.entity = entityDescription
    // If a predicate was specified then use it in the request
    if let predicate = predicate {
        request.predicate = predicate
    }
    
    // If a sort key was passed then use it in the request
    if let sortKey = sortKey {
        // get sort descriptor
        let sortDescriptor = NSSortDescriptor.init(key: sortKey, ascending: sortAscending)
        // set sort descriptor as array
        request.sortDescriptors = [sortDescriptor]
    }
    
    var fetchRequests = [NSManagedObject]()
    // Execute the fetch request
    do {
        // do fetch request
        fetchRequests = try context.fetch(request) as! [NSManagedObject]
    } catch let error as NSError {
        // failure
        print("Couldn't get objects for entity \(entityName) failed: \(error.localizedDescription)")
    }
    
    return fetchRequests
}

func firstObjectForEntity(entityName:String, predicate:NSPredicate, context:NSManagedObjectContext) -> NSManagedObject? {
    // get fetch object
    let fetchedObjects = searchObjectForEntity(entityName: entityName, context: context, predicate: predicate)
    // if entity exist
    if fetchedObjects.count > 0 {
        return fetchedObjects.first
    }
    return nil
}

func getObjectsForEntity(entityName:String,
                         context:NSManagedObjectContext,
                         sortKey:String?=nil,
                         sortAscending:Bool=false) -> [NSManagedObject] {
    return searchObjectForEntity(entityName: entityName, context: context, predicate: nil, sortKey: sortKey, sortAscending: sortAscending)
}

func insertEntityForName(entityName:String, context:NSManagedObjectContext, predicate:NSPredicate? = nil) -> NSManagedObject {
    // return object
    var retObject:NSManagedObject?
    // if predicate exist then search for object first
    if let predicate = predicate {
        // search entire data base
        let objects = searchObjectForEntity(entityName: entityName, context: context, predicate: predicate)
        if objects.count > 0 {
            // retrieve first object
            retObject = objects.first
        }
    }
    
    // is object exist?
    if retObject == nil {
        // insert new object
        retObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
    }
    
    return retObject!
}


// MARK: - Count Objects

// Get a count for an entity with a predicate
func countForEntity(entityName:String, context:NSManagedObjectContext, predicate:NSPredicate? = nil) -> Int {
    // create fetch request
    let request = NSFetchRequest<NSFetchRequestResult>()
    // get entity description for entity name and context
    let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
    // set fetch request with entity description
    request.entity = entityDescription
    
    // If a predicate was specified then use it in the request
    if let predicate = predicate {
        request.predicate = predicate
    }
    
    // do fetch request
    let count = try! context.count(for: request)
    return count
}

// MARK: - Delete Objects
func deleteAllObjectsForEntity(entityName:String, context:NSManagedObjectContext, predicate:NSPredicate? = nil ) -> Bool {
    // create fetch request
    // create fetch request
    let request = NSFetchRequest<NSFetchRequestResult>()
    // get entity description for entity name and context
    let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)
    // set fetch request with entity description
    request.entity = entityDescription
    // Ignore property values for maximum performance
    request.includesPropertyValues = false
    
    // If a predicate was specified then use it in the request
    if let predicate = predicate {
        request.predicate = predicate
    }
    
    var fetchRequests = [NSManagedObject]()
    // Execute the fetch request
    do {
        // do fetch request
        fetchRequests = try context.fetch(request) as! [NSManagedObject]
        // delete all objects
        for managedObject in fetchRequests {
            context.delete(managedObject)
        }
        
    } catch let error as NSError {
        // failure
        print("Couldn't get objects for entity \(entityName) failed: \(error.localizedDescription)")
        return false
    }
    return true
}

// MARK: - Thread Context Management

func getMainManagedObjectContext () -> NSManagedObjectContext {
    // get app delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    // get managedObjectContext
    return appDelegate.persistentContainer.viewContext
}

func startThreadContext() -> NSManagedObjectContext {
    // get managedObjectContext
    let mainMoc = getMainManagedObjectContext()
    // get current thread context
    let thread = Thread.current
    if thread.isMainThread == true {
        return mainMoc
    }
    
    // get thread dictionary
    let threadDictionary = Thread.current.threadDictionary
    if let moc = threadDictionary.object(forKey: "managedObjectContext") as? NSManagedObjectContext {
        // return previous managedObjectContext
        return moc
    } else {
        // create a context for this thread
        let newMoc = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        // set parent context
        newMoc.parent = mainMoc
        // set merge policy
        newMoc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // disable undo resistration for performance
        newMoc.undoManager?.disableUndoRegistration()
        newMoc.undoManager = nil
        // flush operations for which you want undos
        newMoc.processPendingChanges()
        // cache the context for this thread
        threadDictionary.setObject(newMoc, forKey: "managedObjectContext" as NSCopying)
        return newMoc
    }
}

func saveAndStopThreadContext(context:NSManagedObjectContext) {
    // prcess all pending changes
    context.processPendingChanges()
    // save changes in context
    if context.hasChanges {
        do {
            // save managed object
            try context.save()
        } catch let error as NSError {
            // failure
            print("Couldn't save context error(\(error.localizedDescription))")
        }
    }
}

func saveMainContext() {
    saveAndStopThreadContext(context: getMainManagedObjectContext())
}
