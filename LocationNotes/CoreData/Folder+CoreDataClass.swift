//
//  Folder+CoreDataClass.swift
//  LocationNotes
//
//  Created by Роман Мельник on 17.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {
    class func newFolder(name: String) -> Folder  {
        let folder = Folder(context: CoreDataManager.sharedInstance.managedObjecContext)
        
        folder.name = name
        folder.dataUpdate = Date()
        return folder
        
    }
    
    
    func addNote() -> Note {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjecContext)
        
        note.name = name
        note.folder = self
        note.dateUpdate = Date()
        return note
    }
    
    var notesSorted: [Note] {
        let sortDescriptor = NSSortDescriptor(key: "dateUpdate", ascending: false)
        return self.notes?.sortedArray(using: [sortDescriptor]) as! [Note]
    }

}
