//
//  LocationManager.swift
//  LocationNotes
//
//  Created by Роман Мельник on 27.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import CoreLocation
import UIKit

struct LocationCoordinate {
    
    var lat: Double
    var lon: Double
    
    static func create(location: CLLocation) -> LocationCoordinate {
        return LocationCoordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shareInstance = LocationManager()
    var manager = CLLocationManager()
    var blockForSave: ((LocationCoordinate) -> Void)?
    
    func requestAutorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(block: ((LocationCoordinate) -> Void)?) {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            print("🚫🚫🚫 Пользователь не дал доступ к локации")
            return
        }
        
        blockForSave = block
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .other
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = LocationCoordinate.create(location: locations.last!)
        blockForSave?(location)
        manager.stopUpdatingLocation()
    }
    
}
