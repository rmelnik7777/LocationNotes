//
//  NoteAnnotation.swift
//  LocationNotes
//
//  Created by Роман Мельник on 18.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import MapKit
import UIKit

class NoteAnnotation: NSObject, MKAnnotation {
    
    var note: Note?
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(note: Note) {
        self.note = note
        title = note.name
        if note.locationActual != nil {
            coordinate = CLLocationCoordinate2D(latitude: note.locationActual!.lat, longitude: note.locationActual!.lon)
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
    
}
