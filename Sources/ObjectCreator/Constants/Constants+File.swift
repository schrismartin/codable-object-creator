//
//  Constants+File.swift
//  ObjectCreator
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation

extension Constants {
    
    struct File {
        
        static func fileComment(filename: String) -> String {
            
            return """
            //
            //  \(filename)
            //
            //  Created using ObjectCreator
            //
            """
        }
    }
}
