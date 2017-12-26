//
//  App.swift
//  ObjectCreatorPackageDescription
//
//  Created by Chris Martin on 12/25/17.
//

import Foundation
import Files

class App {
    
    var args: Arguments
    
    init(args: Arguments) {
        
        self.args = args
    }
    
    func execute() throws {
        
        args.print()
        
        let fileContents = try extractJson(from: args.filename)
        
        let creator = try ObjectCreator(
            jsonString: fileContents,
            topLevelObjectName: args.name
        )
        
        if args.shouldPrint {
            
            let stringObjects = creator.export()
            print(stringObjects)
        }
        
        if shouldCreateFiles(using: args) {
            
            let folder = try Folder.current.createSubfolderIfNeeded(withName: args.directory)
            let objects = creator.objects
            try write(objects: objects, to: folder)
        }
    }
}

private extension App {
    
    func extractJson(from filename: String) throws -> String {
        
        let file = try Folder.current.file(atPath: filename)
        return try file.readAsString()
    }
    
    func write(objects: [Object], to folder: Folder) throws {
        
        for object in objects {
            
            let filename = "\(object.className).swift"
            let file = try folder.createFileIfNeeded(withName: filename)
            try file.write(string: object.formatted)
        }
    }
    
    func shouldCreateFiles(using args: Arguments) -> Bool {
        
        return !args.shouldPrint || args.directory != Constants.defaultOutputDirectory
    }
}
