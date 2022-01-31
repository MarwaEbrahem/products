//
//  LocalDataManager.swift
//  productsApp
//
//  Created by marwa on 1/30/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit
import CoreData

class LocalDataManager {
    
    public static let sharedInstance = LocalDataManager()
    
    private init() {}
    
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue",attributes: .concurrent)
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
        
    }
    
}

extension LocalDataManager {
    
    func getProductsListFromCoreData(completion: @escaping (Products) -> ()) {
        
        var productsList : Products = []
        guard let managedContext = getContext() else { return }
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "ProductsData")
        concurrentQueue.sync {
            let products = try! managedContext.fetch(fetchReq).first
            guard let productsData = products else {return}
            guard let data = productsData.value(forKey: "productsList") else { return}
            let decoder = JSONDecoder()
            if let loadedProducts = try? decoder.decode(Products.self, from: data as! Data) {
                print(loadedProducts[0].productDescription + " marwa")
                productsList = loadedProducts
            }
            completion(productsList)
        }
        
    }
    
    func addProductsListToCoreData(productsList : Products){
        
        guard let managedContext = getContext() else { return }
        let entity = NSEntityDescription.entity(forEntityName: "ProductsData", in: managedContext)
        let productsData = NSManagedObject(entity: entity!, insertInto: managedContext)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(productsList) {
            concurrentQueue.async(flags: .barrier) {
                productsData.setValue(encoded, forKey: "productsList")
                print("done\n")
            }
        }
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
}
