//
//  ImageNote+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Роман Мельник on 17.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageNote> {
        return NSFetchRequest<ImageNote>(entityName: "ImageNote")
    }

    @NSManaged public var imageBig: Data?
    @NSManaged public var note: Note?

}
