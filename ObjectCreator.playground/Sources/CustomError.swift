import Foundation

public struct CustomError: Error, LocalizedError {
    
    public var localizedDescription: String
    
    public init(description: String) {
        
        localizedDescription = description
    }
}
