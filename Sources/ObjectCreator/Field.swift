//
//  Field.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

struct Field {
    
    // MARK: - Properties
    
    var value: String
    var type: ObjectType
    
    // MARK: - Computed Properties
    
    var isViable: Bool {
        
        return type != .unknown
    }
}

extension Field: Hashable {
    
    var hashValue: Int {
        return value.hashValue
    }
    
    static func == (lhs: Field, rhs: Field) -> Bool {
        
        return lhs.value == rhs.value
            && lhs.type == rhs.type
    }
}
