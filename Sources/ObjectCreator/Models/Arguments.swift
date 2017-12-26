//
//  Arguments.swift
//  ObjectCreator
//
//  Created by Chris Martin on 12/24/17.
//

import Foundation

struct Arguments {
    
    var filename: String
    var name: String
    var directory: String
    var shouldPrint: Bool
    var isDebugMode: Bool
    
    func print() {
        
        guard isDebugMode else { return }
        
        Swift.print("source: \(filename), name: \(name), dir: \(directory), shouldPrint: \(shouldPrint)")
    }
}
