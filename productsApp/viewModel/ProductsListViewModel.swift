//
//  ProductsListViewModel.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsListViewModel : NSObject{
    
    var getProductsObj = ProductsAPI.shared
    var productsList : Products! {
        didSet{
            self.bindProductsListViewModelToView()
        }
    }
    
    var showError : String!{
        didSet{
            self.bindViewModelErrorToView()
        }
    }
    var bindProductsListViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    override init() {
        super .init()
        fetchProductListFromAPI()
    }
    
    
    func fetchProductListFromAPI (){
        
        getProductsObj.getProducts { (result) in
            switch result{
            case .success(let data):
                guard let data = data else {return}
                self.productsList = data
                
            case .failure(_):
                self.showError = "no internet connection"
            }
        }
        
    }
}
