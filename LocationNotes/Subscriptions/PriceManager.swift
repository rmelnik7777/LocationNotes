//
//  PriceManager.swift
//  LocationNotes
//
//  Created by Роман Мельник on 10.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import Foundation
import StoreKit

var versionProduct: SKProduct?
let idFullVersion = "LocationNotes.FullVersion"
let idExtendedVersion = "LocationNotes.ExtendedVersion"

class PriceManager: NSObject {
    
    func getPriceForProduct(idProduct: String) {
        if !SKPaymentQueue.canMakePayments() {
            print("Не возможно делать покупки")
            return
        }
        let request = SKProductsRequest(productIdentifiers: [idProduct])
        request.delegate = self
        request.start()
    }
}

extension PriceManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        if response.invalidProductIdentifiers.isEmpty {
            
        } else {
//            print("Есть неактуальные продукты \(response.invalidProductIdentifiers)")
        }
        
        if response.products.isEmpty {
            
        } else {
            versionProduct = response.products[0]
//            print("Получили продукт: \(fullVersionProduct?.localizedTitle ?? "") / \(fullVersionProduct?.localizedDescription ?? "")")
        }
    }
}
