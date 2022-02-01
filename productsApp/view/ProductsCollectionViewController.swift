//
//  ProductsCollectionViewController.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class ProductsCollectionViewController: UICollectionViewController {
    let productsListViewModelObj = ProductsListViewModel()
    var productsListData : Products = []
    var waiting = false
    override func viewDidLoad() {
        super.viewDidLoad()
        productsListViewModelObj.productsList.bind { [weak self] (products) in
            guard let self = self else {return}
            guard let products = products else {return}
            print(products[7].productDescription)
            self.loadData(products: products)
        }
        productsListViewModelObj.showError.bind { (error) in
            print("" + "errror show")
        }
    }
    func loadData(products: Products) {
        self.productsListData.append( contentsOf: products )
        self.collectionView.reloadData()
    }
    func loadMoreData() {
        if !self.waiting {
            self.waiting = true
            DispatchQueue.global().async {
                self.productsListViewModelObj.fetchProductListData()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.waiting = false
                }
            }
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsListData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! ProductsCollectionViewCell
        
        let products =  self.productsListData[indexPath.row]
        cell.productsData = products
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == productsListData.count-1 && !self.waiting  {
            self.loadMoreData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = (self.storyboard?.instantiateViewController(identifier: Constants.detailsVC )) as! DetailsViewController
        details.productData = self.productsListData[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    
}
extension ProductsCollectionViewController :  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 200, height: 300)
    }
    
}
