//
//  ProductsListViewModel.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsListViewModel{
    
    var ProductsDataFacadeObj = ProductsDataFacade()
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
        fetchProductListData()
    }
    
    
    func fetchProductListData(){
        ProductsDataFacadeObj.fetchProductsListData {[weak self] (products) in
            guard let self = self else {return}
            if products.count == 0 {
                DispatchQueue.main.async {
                    self.showError = "some error happen"
                }
                
               // print("\(products.count)" + "marwa")
            }else{
                self.productsList = products
              print( self.productsList[3].productDescription)
                print("\(products.count)" + "marwa")
                
            }
        }
    }
}
