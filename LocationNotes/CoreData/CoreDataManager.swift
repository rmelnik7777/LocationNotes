//
//  CoreDataManager.swift
//  LocationNotes
//
//  Created by Роман Мельник on 20.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import CoreData
import UIKit

var folders: [Folder] {
    let request = NSFetchRequest<Folder>(entityName: "Folder")
    let sortDescription = NSSortDescriptor(key: "name", ascending: true)
    request.sortDescriptors = [sortDescription]
    let array = try? CoreDataManager.sharedInstance.managedObjecContext.fetch(request)
    if array != nil {
        return array!
    }
    return []
}

var notes: [Note] {
    let request = NSFetchRequest<Note>(entityName: "Note")
    let sortDescription = NSSortDescriptor(key: "dateUpdate", ascending: false)
    request.sortDescriptors = [sortDescription]
    let array = try? CoreDataManager.sharedInstance.managedObjecContext.fetch(request)
    if array != nil {
        return array!
    }
    return []
}

class CoreDataManager {

    // MARK: - Core Data stack
    
    static let sharedInstance = CoreDataManager()

    var managedObjecContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "LocationNotes")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
