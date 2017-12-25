//
//  ArgumentParser.swift
//  ObjectCreator
//
//  Created by Chris Martin on 12/24/17.
//

import Foundation

/// Struct containt program arguments
struct ArgumentParsers {
    
    /// Bits / Genes in a genetic string
    var filename: URL
    
    init(args: [String]) throws {
        guard args.count == 2 else { throw Error(description: "Invalid number of arguments.") }
        
        guard let url = URL(string: args[1]) else {
            throw Error(description: "Expected filename for first argument.")
        }
        
        filename = url
    }
    
    struct Error: Swift.Error {
        
        var localizedDescription: String
        
        init(description: String) {
            
            localizedDescription = description
        }
    }
}
