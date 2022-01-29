//
//  ProductsCollectionViewCell.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    
    var productsData:Product!{
        didSet{
            productPrice.text = "\(productsData.price)"
            productDesc.text = productsData.productDescription
            productImage.loadFrom(URLAddress: productsData.image.url)
        }
    }
}
