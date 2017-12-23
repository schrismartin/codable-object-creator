import Foundation

public struct ObjectCreator {
    
    public var json: JSON
    public var topLevelObjectName: String
    
    public init(json: JSON, topLevelObjectName: String) {
        
        self.json = json
        self.topLevelObjectName = topLevelObjectName
    }
    
    public init(jsonString: String, topLevelObjectName: String) throws {
        
        guard let data = jsonString.data(using: .utf8) else {
            throw CustomError(description: "Could not create data from provided string.")
        }
        
        json = try ObjectCreator.parse(data: data)
        self.topLevelObjectName = topLevelObjectName
    }
    
    public func export() -> String {
        
        return createJSONObjects(for: json, named: topLevelObjectName)
    }
}

private extension ObjectCreator {
    
    static func parse(data: Data) throws -> JSON {
        
        let json = try JSONSerialization.jsonObject(with: data)
        
        guard let typedJson = json as? JSON else {
            throw CustomError(description: "Could not convert json to [String: Any]")
        }
        
        return typedJson
    }
    
    func createJSONObjects(for json: JSON, named className: String) -> String {
        
        var needsCodingKeys = false
        
        var formattedObject = "struct \(className): Codable {\n\n"
        var futureObjects = [Object]()
        
        for (key, value) in json {
            
            let camelCasedKey = key.camelCased(capitalized: false)
            if key != camelCasedKey { needsCodingKeys = true }
            
            var type = swiftType(of: value)
            
            if let value = value as? [JSON] {
                let className = typeName(from: key)
                let pair = Object(className: className, contents: value.first!)
                futureObjects.append(pair)
                type = .custom(className, isArray: true)
            }
            
            if let value = value as? JSON {
                let className = typeName(from: key)
                let pair = Object(className: className, contents: value)
                futureObjects.append(pair)
                type = .custom(className, isArray: false)
            }
            
            formattedObject += "\(indention(level: 1))var \(camelCasedKey): \(type.name)\n"
        }
        
        if needsCodingKeys {
            let keys = Array(json.keys)
            formattedObject += "\n\(createCodingKeys(for: keys))\n"
        }
        
        formattedObject += "}"
        
        for object in futureObjects {
            
            formattedObject += "\n\n\(createJSONObjects(for: object.contents, named: object.className))"
        }
        
        return formattedObject
    }
    
    func createCodingKeys(for variableNames: [String]) -> String {
        
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

extension ObjectCreator {
    
    struct Object {
        
        var className: String
        var contents: JSON
    }
}
