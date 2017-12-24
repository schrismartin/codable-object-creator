import Foundation

public struct ObjectCreator {
    
    private var objects: [Object]
    
    public init(json: JSON, topLevelObjectName: String) {
        
        objects = Object.createObjects(using: json, topLevelObjectName: topLevelObjectName)
    }
    
    public init(jsonString: String, topLevelObjectName: String) throws {
        
        guard let data = jsonString.data(using: .utf8) else {
            throw CustomError(description: "Could not create data from provided string.")
        }
        
        let json = try ObjectCreator.parse(data: data)
        self.init(json: json, topLevelObjectName: topLevelObjectName)
    }
    
    public func export() -> String {
        
        return objects
            .map { $0.formatted }
            .joined(separator: "\n\n")
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
}
