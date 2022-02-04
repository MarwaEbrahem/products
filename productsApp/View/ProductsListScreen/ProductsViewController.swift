//
//  ProductsViewController.swift
//  productsApp
//
//  Created by marwa on 2/2/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let productsListViewModelObj : ProductListViewModelType = ProductsListViewModel()
    let layout = UICollectionViewFlowLayout()
    let transition = CustomTransition()
    var productsListData : Products = []
    var loadingView: LoadingReusableView?
    var waiting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let itemCellNib = UINib(nibName: Constants.productCellNib, bundle: nil)
        self.collectionView.register(itemCellNib, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        let loadingReusableNib = UINib(nibName: Constants.loadingReusableNib, bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Constants.loadingReusableNib)
        
        productsListViewModelObj.productsList.bind { [weak self] (products) in
            guard let self = self else {return}
            guard let products = products else {return}
            self.loadData(products: products)
        }
        
        productsListViewModelObj.showError.bind { (error) in
            self.displayAlert()
        }
    }
    
}

extension ProductsViewController {
    
    func loadData(products: Products) {
        waiting = false
        self.productsListData.append( contentsOf: products )
        self.collectionView.reloadData()
    }
    
    func loadMoreData() {
        if !self.waiting {
            self.waiting = true
            self.productsListViewModelObj.fetchProductListData()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.waiting = false
            }
        }
    }
    
}


extension ProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource ,  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let products =  self.productsListData[indexPath.row]
        cell.productsData = products
        cell.maxWidth = collectionView.frame.width / 2 - 5
        cell.maxHeight = CGFloat(products.image.height)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = (self.storyboard?.instantiateViewController(identifier: Constants.detailsVC )) as! DetailsViewController
        details.productData = self.productsListData[indexPath.row]
       self.navigationController?.pushViewController(details, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsety = scrollView.contentOffset.y
        let height = scrollView.contentSize.height
        if offsety > height - scrollView.frame.size.height  && !self.waiting{
            print("reload")
            self.loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.waiting {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.loadingReusableNib, for: indexPath) as! LoadingReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    
}

extension ProductsViewController : UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.popStyle = (operation == .pop)
        return transition
    }
}
