//
//  ObjectCollection.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

struct ObjectCollection {
    
    var collection = [Int: Object]()
    
    var contents: [Object] {
        
        return collection.map { $0.value }
    }
    
    mutating func add(object: Object) {
        
        let key = object.hashValue
        
        if let currentObject = collection[key], currentObject.isMoreViable(than: object) {
            return
        }
        else {
            collection[key] = object
        }
    }
    
    mutating func add(objects: [Object]) {
        
        for object in objects {
            add(object: object)
        }
    }
    
    mutating func remove(object: Object) {
        
        let key = object.hashValue
        collection[key] = nil
    }
}
