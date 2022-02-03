//
//  viewModelContracts.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation

protocol ProductListViewModelType {
      func fetchProductListData()
      var productsList : Bindable<Products> {get}
      var showError : Bindable<String> {get}
}
protocol ProductsDataFacadeType {
     func fetchProductsListData(completion: @escaping (Products) -> ())
}
