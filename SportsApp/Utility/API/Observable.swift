//
//  Rsponse.swift
//  SportsApp
//
//  Created by Mac on 30/01/2024.
//

import Foundation

class Observable<T> {
    
    var value : T?{
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    private var listener : ((T?)-> Void)?

    init(value: T? = nil) {
        self.value = value
    }
    
    func bind(_ listener : @escaping ((T?)-> Void)){
        listener(value)
        self.listener = listener
    }
}
