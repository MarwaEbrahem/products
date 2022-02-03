//
//  Bindable.swift
//  productsApp
//
//  Created by marwa on 1/31/22.
//  Copyright © 2022 marwa. All rights reserved.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
    
}
