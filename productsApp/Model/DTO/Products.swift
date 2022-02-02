//
//  Products.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let productDescription: String
    let image: Image
    let price: Int
}

// MARK: - Image
struct Image: Codable {
    let width, height: Int
    let url: String
}

typealias Products = [Product]
