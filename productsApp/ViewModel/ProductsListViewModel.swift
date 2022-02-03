//
//  ProductsListViewModel.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
class ProductsListViewModel : ProductListViewModelType{
    
    var ProductsDataFacadeObj : ProductsDataFacadeType = ProductsDataFacade()
    var productsList = Bindable<Products>()
    var showError = Bindable<String>()
    
    init() {
        fetchProductListData()
    }
    
    
    func fetchProductListData(){
        ProductsDataFacadeObj.fetchProductsListData {[weak self] (products) in
            guard let self = self else {return}
            if products.count == 0 {
                self.showError.value = "no internet connection"
            }else{
                self.productsList.value = products
            }
        }
    }
}
