//
//  NoteMapVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 04.03.2020.
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


class NoteMapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        if note?.locationActual != nil {
            mapView.addAnnotation(NoteAnnotation(note: note!))
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: (note?.location!.lat)!, longitude: (note?.location!.lon)!)
        }
        
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
        let point = recongnizer.location(in: mapView)
        let c = mapView.convert(point, toCoordinateFrom: mapView)
        
        note?.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
        CoreDataManager.sharedInstance.saveContext()
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(NoteAnnotation(note: note!))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.pinTintColor = UIColor.yellow
        pin.isDraggable = true
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == .ending {
            let newLocation = LocationCoordinate(lat: (view.annotation?.coordinate.latitude)!, lon: (view.annotation?.coordinate.longitude)!)
                note?.locationActual = newLocation
            CoreDataManager.sharedInstance.saveContext()
        }
        print("Поменяли локацию")
    }
    
}
