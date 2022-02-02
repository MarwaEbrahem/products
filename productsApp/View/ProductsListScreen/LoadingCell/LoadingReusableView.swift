//
//  LoadingReusableView.swift
//  productsApp
//
//  Created by marwa on 2/2/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class LoadingReusableView: UICollectionReusableView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.color = UIColor.black
    }
    
}
