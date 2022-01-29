//
//  ProductsListViewModel.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsListViewModel{
    
    var getProductsObj : ProductsAPIProtocol = ProductsAPI.shared
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
    
    init() {
        fetchProductListFromAPI()
    }
    
    
    func fetchProductListFromAPI (){
        
        getProductsObj.getProducts { [weak self](result) in
            switch result{
            case .success(let data):
                guard let data = data else {return}
                guard let self = self else {return}
                self.productsList = data
                
            case .failure(_):
                guard let self = self else {return}
                self.showError = "no internet connection"
            }
        }
        
    }
}
