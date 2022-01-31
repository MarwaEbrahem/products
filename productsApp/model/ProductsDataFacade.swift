//
//  ProductsDataFacade.swift
//  productsApp
//
//  Created by marwa on 1/30/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsDataFacade {
    private let productsAPIObj : ProductsAPIProtocol = ProductsAPI.shared
    private let localProductsDataObj = LocalDataManager.sharedInstance
    private var isOnline = Reachability.isConnectedToNetwork()
    
    func fetchProductsListData(completion: @escaping (Products) -> ()) {
        if isOnline {
            fetchAPIData { [weak self](products) in
                guard let self = self else {return}
                self.localProductsDataObj.addProductsListToCoreData(productsList: products)
                completion(products)
            }
        }else{
            fetchLocalData { (products) in
                print(products.count)
                DispatchQueue.main.async {
                     completion(products)
                }
            }
        }
    }
    
    private func fetchAPIData(completion: @escaping (Products) -> ()) {
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
    
    private func fetchLocalData(completion: @escaping (Products) -> ()){
        localProductsDataObj.getProductsListFromCoreData { (result) in
            print("\(result)" + " marwa")
                completion(result)
        }
    }
    
}
