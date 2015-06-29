//
//  QueueController.swift
//  Splat Simple
//
//  Created by Matthew Falzon on 29/06/2015.
//  Copyright (c) 2015 Matthew Falzon. All rights reserved.
//

import Foundation

class Queue<T:NSObject> {

    var count: Int = 0
    var head: Node<T> = Node<T>()
    var tail: Node<T> = Node<T>()
    
    init(){
        
    }
    
    func isEmpty() -> Bool {
        
        return self.count == 0
        
    }
    
    // Add item to queue
    func enqueue(value:T) {
        
        var node = Node<T>(value: value)
        if self.isEmpty() {
            self.head = node
            self.tail = node
            
        } else {
            node.next = self.head
            self.head = node
        }
        
        self.count++
    }
    
    // Remove item from queue
    func dequeue() -> T? {
        
        if self.isEmpty() {
            return nil
            
        } else if self.count == 1 {
            var temp: Node<T> = self.tail
            self.count--
            return temp.value
            
        } else {
            var temp: Node<T> = self.tail
            
            self.tail = self.tail.prev!
            
            self.count--
            return temp.value
        }
    }
    
}