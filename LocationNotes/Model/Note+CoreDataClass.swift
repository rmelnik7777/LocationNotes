//
//  Note+CoreDataClass.swift
//  LocationNotes
//
//  Created by Роман Мельник on 17.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    class func newNote(name: String, inFolder: Folder?) -> Note  {
        let note = Note(context: CoreDataManager.sharedInstance.managedObjecContext)
        
        note.name = name
        note.dateUpdate = Date()
        
//        if let inFolder = inFolder{
            note.folder = inFolder
//        }
        return note
    }
    
    var imageActual: UIImage? {
        set{
            if newValue == nil {
                if self.image != nil {
                    CoreDataManager.sharedInstance.managedObjecContext.delete(self.image!)
                }
                self.imageSmall = nil
            } else {
                if self.image != nil {
                    self.image = ImageNote(context: CoreDataManager.sharedInstance.managedObjecContext)
                }
                self.image?.imageBig = newValue!.jpegData(compressionQuality: 1)
                self.imageSmall = newValue!.jpegData(compressionQuality: 0.03)
            }
            dateUpdate = Date()
        }
        get {
            if self.image != nil {
                
                if image?.imageBig != nil {
                    return UIImage(data: self.image!.imageBig!)
                }
            }
            return nil
        }
    }
    
    func addImage(image: UIImage){
        let imageNote = ImageNote(context: CoreDataManager.sharedInstance.managedObjecContext)
        imageNote.imageBig = image.jpegData(compressionQuality: 1)
        self.image = imageNote
    }
    
    func addLocation(latitude: Double, longitude: Double) {
        let location = Location(context: CoreDataManager.sharedInstance.managedObjecContext)
        location.lat = latitude
        location.lon = longitude
        self.location = location
    }
    
    var dateUpdateString: String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: self.dateUpdate)
    }

}
