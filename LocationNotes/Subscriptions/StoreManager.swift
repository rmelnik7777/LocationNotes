//
//  StoreManager.swift
//  LocationNotes
//
//  Created by Роман Мельник on 11.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import StoreKit
import UIKit

class StoreManager: NSObject {
    
    static var isFullVersion: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isFull")
            UserDefaults.standard.synchronize()
        }
        get {
            UserDefaults.standard.bool(forKey: "isFull")
        }
    }
        
    func buyFullVersion() {
        if let versionProduct = versionProduct {
            let payment = SKPayment(product: versionProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            if !SKPaymentQueue.canMakePayments() {
                print("Не возможно делать покупки")
                return
            }
            let request = SKProductsRequest(productIdentifiers: [idFullVersion])
            request.delegate = self
            request.start()
        }
    }
    
    func restoreFullVersion() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension StoreManager: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .deferred {
                print("Transaction is deferred")
            }
            if transaction.transactionState == .failed {
                print("Transaction is failed")
                print("Error: \(transaction.error?.localizedDescription ?? "")")
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchased {
                print("Transaction is purchased")
                if transaction.payment.productIdentifier == idFullVersion {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
            if transaction.transactionState == .purchasing {
                print("Transaction is purchasing")
            }
            if transaction.transactionState == .restored {
                print("Transaction is restored")
                if transaction.payment.productIdentifier == idFullVersion {
                    StoreManager.isFullVersion = true
                }
                queue.finishTransaction(transaction)
                queue.remove(self)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error){
        
    }
    
    
}

extension StoreManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.invalidProductIdentifiers.isEmpty {
            print("Пусто")
        } else {
            print("Есть неактуальные продукты \(response.invalidProductIdentifiers)")
        }
        
        if response.products.isEmpty {
            print("нет продуктов")
        } else {
            versionProduct = response.products[0]
            print("Получили продукт: \(versionProduct?.localizedTitle ?? "") / \(versionProduct?.localizedDescription ?? "")")
            self.buyFullVersion()
        }
    }
}


class BuyingForm {
    
    var isNeedToShow: Bool {
        if StoreManager.isFullVersion {
            return false
        }
        if notes.count <= 3 {
            return false
        }
        return true
    }
    var storeManager = StoreManager()
    
    func showForm(inController: UIViewController) {
        if let versionProduct = versionProduct {
            let alertController = UIAlertController(title: versionProduct.localizedTitle, message: versionProduct.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            let actionBuy = UIAlertAction(title: "Buy for \(versionProduct.price) \(versionProduct.priceLocale.currencySymbol!)", style: UIAlertAction.Style.default) { (alert) in
                self.storeManager.buyFullVersion()
            }
            let actionRestore = UIAlertAction(title: "Restore", style: UIAlertAction.Style.default) { (alert) in
                self.storeManager.restoreFullVersion()
            }
            let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (alert) in
                
            }
            
            alertController.addAction(actionBuy)
            alertController.addAction(actionRestore)
            alertController.addAction(actionCancel)
            
            inController.present(alertController, animated: true, completion: nil)
        }
    }
}
