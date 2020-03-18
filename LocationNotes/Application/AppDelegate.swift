//
//  AppDelegate.swift
//  LocationNotes
//
//  Created by Роман Мельник on 17.02.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import CoreData
import Rswift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var priceManager = PriceManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        Router.shared.showInitialVC()
        
//        priceManager.getPriceForProduct(idProduct: "LocationNotes.FullVersion")
//        priceManager.getPriceForProduct(idProduct: "LocationNotes.ExtendedVersion")
//        print(NSLocalizedString("all note", comment: ""))
        
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.sharedInstance.saveContext()
    }

}
