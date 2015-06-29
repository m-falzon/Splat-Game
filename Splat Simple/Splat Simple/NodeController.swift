//
//  NodeController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 29/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

import Foundation

class Node<T:NSObject> {
    
    var value: T? = nil
    var next: Node<T>? = nil
    var prev: Node<T>? = nil
    
    init() {
        
    }
    
    init(value: T) {
        self.value = value
    }
}
