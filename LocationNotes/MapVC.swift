//
//  MapVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 05.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import MapKit
import UIKit

class MapVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
              mapView.gestureRecognizers = [ltgr]
    }
          
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.removeAnnotations(mapView.annotations)
        
        for note in notes where note.locationActual != nil {
            mapView.addAnnotation(NoteAnnotation(note: note))
//            if note.locationActual != nil {
//                mapView.addAnnotation(NoteAnnotation(note: note))
//            }
        }
    }
    
    // MARK: - Long Tapped for map
    
    @objc func handleLongTap(recongnizer: UIGestureRecognizer) {
        if recongnizer.state != .began {
            return
        }
        let point = recongnizer.location(in: mapView)
        let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
      
      let newNote = Note.newNote(name: "New Note", inFolder: nil)
      newNote.locationActual = LocationCoordinate(lat: coordinate.latitude, lon: coordinate.longitude)
      
      goToNote(note: newNote)
      
    }
    
    // MARK: - Navigation

    func goToNote(note: Note?) {
        guard let vc = Router.shared.noteVC() else { return }
        vc.note = note
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - MapDelegate

extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            DispatchQueue.main.async {
                mapView.setCenter(annotation.coordinate, animated: true)
            }
            return nil
        }
        
       let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: UIButton.ButtonType.detailDisclosure)
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let selectedNote = (view.annotation as? NoteAnnotation)?.note
        goToNote(note: selectedNote)
    }
}
