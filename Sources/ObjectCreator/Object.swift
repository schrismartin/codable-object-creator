//
//  Object.swift
//  ObjectCreator
//
//  Created by Chris Martin on 12/24/17.
//

import Foundation

struct Object {
    
    // MARK: - Properties
    
    var className: String
    var shouldExportCodingKeys = false
    
    // MARK: - Private Properties
    
    private var fields = [Field]()
    
    // MARK: - Initializers
    
    private init(className: String, fields: [Field]) {
        
        self.className = className
        self.fields = fields
    }
    
    public static func createObjects(using json: JSON, topLevelObjectName name: String) -> [Object] {
        
        var needsCodingKeys = false
        var objects = [Object]()
        var fields = [Field]()
        
        for (key, value) in json {
            
            let camelCasedKey = key.camelCased(capitalized: false)
            if key != camelCasedKey { needsCodingKeys = true }
            
            var type = swiftType(of: value)
            
            if let value = value as? [JSON] {
                let className = typeName(from: key)
                let subObjects = Object.createObjects(using: value.first!, topLevelObjectName: className)
                objects += subObjects
                type = .custom(className, isArray: true)
            }
            
            if let value = value as? JSON {
                let className = typeName(from: key)
                let subObjects = Object.createObjects(using: value, topLevelObjectName: className)
                objects += subObjects
                type = .custom(className, isArray: false)
            }
            
            let field = Field(value: key, type: type)
            fields.append(field)
        }
        
        var object = Object(className: name, fields: fields)
        object.shouldExportCodingKeys = needsCodingKeys
        
        return [object] + objects
    }
    
    // MARK: - Computed Properties
    
    public var formatted: String {
        
        var formattedObject = "struct \(className): Codable {\n\n"
        
        for field in fields {
            
            formattedObject += "\(indention(level: 1))var \(field.value.camelCased()): \(field.type.name)\n"
        }
        
        if shouldExportCodingKeys {
            
            let variableNames = fields.map { $0.value }
            formattedObject += "\n\(createCodingKeys(for: variableNames))\n"
        }
        
        formattedObject += "}"
        
        return formattedObject
    }
}

// MARK: - Helper
private extension Object {
    
    private func createCodingKeys(for variableNames: [String]) -> String {
        
        var codingKeysString = "\(indention(level: 1))enum CodingKeys: String, CodingKey {\n\n"
        
        for variableName in variableNames {
            let enumCase = variableName.camelCased()
            let value = variableName
            
            codingKeysString += "\(indention(level: 2))case \(enumCase) = \"\(value)\"\n"
        }
        
        codingKeysString += "\(indention(level: 1))}"
        
        return codingKeysString
    }
}

// MARK: - Assistant Objects
private extension Object {
    
    struct Field {
        
        var value: String
        var type: ObjectType
    }
}
