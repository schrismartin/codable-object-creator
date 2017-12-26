//
//  CustomError.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

struct CustomError: Error {
    
    var localizedDescription: String
    
    init(description: String) {
        
        localizedDescription = description
    }
}
