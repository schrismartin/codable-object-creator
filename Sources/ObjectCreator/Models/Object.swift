//
//  Object.swift
//  ObjectCreator
//
//  Created by Chris Martin on 12/24/17.
//

import Foundation

struct Object: PreferenceQuantifiable {
    
    // MARK: - Properties
    
    var className: String
    var shouldExportCodingKeys = false
    let preference: Double
    
    // MARK: - Private Properties
    
    private var fields = Set<Field>()
    
    // MARK: - Initializers
    
    private init(className: String, fields: Set<Field>) {
        
        self.className = className
        self.fields = fields
        
        let fieldViabilityScore = fields.reduce(0) { $0 + $1.preference }
        preference = fieldViabilityScore / Double(fields.count)
    }
    
    public static func createObjects(using json: JSON, topLevelObjectName name: String) -> [Object] {
        
        var needsCodingKeys = false
        var objects = PreferentialSet<Object>()
        var fields = PreferentialSet<Field>()
        
        for (key, value) in json {
            
            let camelCasedKey = key.camelCased(capitalized: false)
            if key != camelCasedKey { needsCodingKeys = true }
            
            var type = swiftType(of: value)
            
            if let values = value as? [JSON] {
                
                let className = typeName(from: key)
                for value in values {
                    
                    let childObjects = Object.createObjects(using: value, topLevelObjectName: className)
                    objects.add(objects: childObjects)
                }
                
                type = .custom(className, isArray: true)
            }
            
            if let value = value as? JSON {
                
                let className = typeName(from: key)
                let childObjects = Object.createObjects(using: value, topLevelObjectName: className)
                objects.add(objects: childObjects)
                type = .custom(className, isArray: false)
            }
            
            let field = Field(value: key, type: type)
            fields.add(object: field)
        }
        
        var object = Object(className: name, fields: fields.set)
        object.shouldExportCodingKeys = needsCodingKeys
        
        objects.add(object: object)
        return objects.array
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
            
            if variableName == variableName.camelCased() {
                codingKeysString += "\(indention(level: 2))case \(enumCase)\n"
            } else {
                codingKeysString += "\(indention(level: 2))case \(enumCase) = \"\(value)\"\n"
            }
        }
        
        codingKeysString += "\(indention(level: 1))}"
        
        return codingKeysString
    }
}

extension Object: Hashable {
    
    var hashValue: Int {
        
        return className.hashValue ^ fields.hashValue
    }
    
    static func == (lhs: Object, rhs: Object) -> Bool {
        
        return lhs.hashValue == rhs.hashValue
    }
}
