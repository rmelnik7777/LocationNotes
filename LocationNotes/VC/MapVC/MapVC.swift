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

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
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
            
            let newNote = Note.newNote(name: "🙊", inFolder: nil)
            newNote.locationActual = LocationCoordinate(lat: c.latitude, lon: c.longitude)
     
            
            let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteVC
            noteController.note = newNote
            navigationController?.pushViewController(noteController, animated: true)
          }
    
    override func viewWillAppear(_ animated: Bool) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for note in notes {
            if note.locationActual != nil {
                mapView.addAnnotation(NoteAnnotation(note: note))
            }
        }
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
        let selectedNote = (view.annotation as! NoteAnnotation).note
        
        let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteVC
        noteController.note = selectedNote
        navigationController?.pushViewController(noteController, animated: true)
//        present(noteController, animated: true, completion:  nil)
    }
}
