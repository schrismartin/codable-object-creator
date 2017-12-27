//
//  Constants+Arguments.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation
import Commander

extension Constants {
    
    struct Arguments {
        
        static let source = Argument<String>(
            "source",
            description: "file path of json file, relative to the current directory"
        )
        
        static let objectName = Argument<String>(
            "name",
            description: "name of top-level object"
        )
        
        static let directory = Option(
            "dir",
            default: Constants.defaultOutputDirectory,
            description: "Output directory to write resulting files"
        )
        
        static let print = Flag(
            "print",
            default: false,
            flag: "p",
            description: "Print resulting file contents to the console"
        )
        
        static let debug = Flag(
            "debug",
            default: false,
            flag: "d",
            description: "Print debug information to the console"
        )
    }
}
