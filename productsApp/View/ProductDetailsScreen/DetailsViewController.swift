//
//  ViewController.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productDes: UILabel!
    var productData : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let productData = productData else {return}
        productImg.loadFrom(URLAddress: productData.image.url)
        productDes.text = productData.productDescription
    }
    
    
}

