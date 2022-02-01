//
//  ProductsAPI.swift
//  productsApp
//
//  Created by marwa on 1/29/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation

protocol ProductsAPIProtocol{
    
    func getProducts(completion: @escaping (Result<Products?,NSError>) -> ())
}

class ProductsAPI: ProductsAPIProtocol {
    
    static let shared = ProductsAPI()
    private let concurrentQueue = DispatchQueue(label: "concurrentQueue",attributes: .concurrent)
    private init() {}
    
    func getProducts(completion: @escaping (Result<Products?, NSError>) -> ()) {
        let url = URL(string: Constants.url )!
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(NSError()))
                return
            }
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Products.self, from: data)
                print(response[0].id)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
                
                
            } catch {
                print(error)
            }
        }
        concurrentQueue.sync {
            task.resume()
        }
    }
    
}
