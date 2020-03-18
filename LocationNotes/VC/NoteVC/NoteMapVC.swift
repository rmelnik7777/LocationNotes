//
//  NoteMapVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 04.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import MapKit

class NoteMapVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var note: Note?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMap()
    }
    
    // MARK: - Helper
    func prepareMap() {
        mapView.delegate = self
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
        if note?.locationActual != nil {
            mapView.addAnnotation(NoteAnnotation(note: note!))
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: (note?.location!.lat)!, longitude: (note?.location!.lon)!)
        }
    }
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
        let point = recongnizer.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
        
        note?.locationActual = LocationCoordinate(lat: coordinate.latitude, lon: coordinate.longitude)
        CoreDataManager.sharedInstance.saveContext()
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(NoteAnnotation(note: note!))
    }
}

// MARK: - MapDelegate
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
    }
    
}
