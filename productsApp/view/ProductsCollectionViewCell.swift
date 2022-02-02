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
            productPrice.text = "\(productsData.price)$"
            productDesc.text = productsData.productDescription
            productImage.loadFrom(URLAddress: productsData.image.url)
        }
    }
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
            didSet {
                maxWidthConstraint.isActive = false
            }
        }
        @IBOutlet private var maxHeightConstraint: NSLayoutConstraint! {
            didSet {
                maxHeightConstraint.isActive = false
            }
        }
    
        var maxWidth: CGFloat? = nil {
            didSet {
                guard let maxWidth = maxWidth else {
                    return
                }
                maxWidthConstraint.isActive = true
                maxWidthConstraint.constant = maxWidth
            }
        }
        var maxHeight: CGFloat? = nil {
            didSet {
                guard let maxHeight = maxHeight  else {
                    return
                }
                maxHeightConstraint.isActive = true
                maxHeightConstraint.constant = maxHeight
            }
        }
}
