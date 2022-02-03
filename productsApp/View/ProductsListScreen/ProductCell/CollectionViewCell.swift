//
//  CollectionViewCell.swift
//  productsApp
//
//  Created by marwa on 2/2/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImg: UIImageView!
    @IBOutlet private weak var productPrice: UILabel!
    @IBOutlet private weak var productDes: UILabel!
    
    var productsData:Product!{
        didSet{
            productPrice.text = "\(productsData.price)$"
            productDes.text = productsData.productDescription
            productImg.loadFrom(URLAddress: productsData.image.url)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
