//
//  ProductsDataFacade.swift
//  productsApp
//
//  Created by marwa on 1/30/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsDataFacade : ProductsDataFacadeType {
    let productsAPIObj : ProductsAPIProtocol = ProductsAPI.shared
    let localProductsDataObj : LocalDataManagerProtocol = LocalDataManager.sharedInstance
    var isOnline = Reachability.isConnectedToNetwork()
    
    func fetchProductsListData(completion: @escaping (Products) -> ()) {
        if isOnline {
            fetchAPIData { [weak self](products) in
                guard let self = self else {return}
                self.localProductsDataObj.addProductsListToCoreData(productsList: products)
                completion(products)
            }
        }else{
            fetchLocalData { (products) in
                DispatchQueue.main.async {
                    completion(products)
                }
            }
        }
    }
    
    func fetchAPIData(completion: @escaping (Products) -> ()) {
        productsAPIObj.getProducts {(result) in
            switch result {
            case .success(let data):
                guard let data = data else {return}
                completion(data)
            case .failure(_):
                completion([])
            }
        }
    }
    
    func fetchLocalData(completion: @escaping (Products) -> ()){
        localProductsDataObj.getProductsListFromCoreData { (result) in
            completion(result)
        }
    }
    
}
