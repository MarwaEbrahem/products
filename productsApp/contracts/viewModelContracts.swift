//
//  viewModelContracts.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation
protocol ProductListViewModelType {
    var bindProductsListViewModelToView : (()->()) {get set}
    var bindViewModelErrorToView : (()->()) {get set}
   // var productsList : Products {get set}
  //  var showError : String {get set}
}
