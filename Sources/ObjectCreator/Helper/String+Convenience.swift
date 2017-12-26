import Foundation

extension String {
    
    public func camelCased(capitalized: Bool = false) -> String {
        
        let original = capitalized ? self.capitalized : self
        var characters = original.map { String($0) }
        
        for index in characters.indices {
            
            if characters[index] == "_" {
                
                let nextIndex = index + 1
                guard nextIndex < characters.count else { break }
                
                characters[nextIndex] = characters[nextIndex].uppercased()
            }
        }
        
        return characters
            .filter { $0 != "_" }
            .joined()
    }
}
