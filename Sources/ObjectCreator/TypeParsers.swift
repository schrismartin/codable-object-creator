import Foundation

public func typeName(from name: String) -> String {
    
    var name = name
    
    let lastIndex = name.index(before: name.endIndex)
    if name[lastIndex] == "s" {
        name = String(name[..<lastIndex])
    }
    
    return name.camelCased(capitalized: true)
}

public func swiftType(of value: Any) -> ObjectType {
    
    if value is Bool {
        return .bool
    }
    
    if value is Double {
        return .double
    }
    
    if value is Int {
        return .int
    }
    
    if value is String {
        return .string
    }
    
    return .unknown
}

public enum ObjectType {
    
    case string
    case double
    case int
    case bool
    case date(formatter: DateFormatter)
    case custom(String, isArray: Bool)
    case unknown
    
    var name: String {
        
        switch self {
        case .string: return "String"
        case .double: return "Double"
        case .int: return "Int"
        case .bool: return "Bool"
        case .date: return "Date"
        case .custom(let type, let isArray): return isArray ? "[\(type)]" : type
        case .unknown: return "<#Type#>"
        }
    }
}
