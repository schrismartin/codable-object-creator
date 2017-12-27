//
//  ObjectCollection.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

struct PreferentialSet<ItemType: PreferenceQuantifiable & Hashable> {
    
    var collection = [Int: ItemType]()
    
    var array: [ItemType] {
        
        return collection.map { $0.value }
    }
    
    var set: Set<ItemType> {
        
        return Set(array)
    }
    
    mutating func add(object: ItemType) {
        
        let key = object.hashValue
        if let currentObject = collection[key], currentObject.isPrefered(over: object) {
            return
        }
        else {
            collection[key] = object
        }
    }
    
    mutating func add(objects: [ItemType]) {
        
        for object in objects {
            add(object: object)
        }
    }
    
    mutating func remove(object: ItemType) {
        
        let key = object.hashValue
        collection[key] = nil
    }
}
