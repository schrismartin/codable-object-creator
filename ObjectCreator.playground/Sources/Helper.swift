import Foundation

func indention(level: Int) -> String {
    
    var indent = ""
    for _ in 0..<level {
        indent += "    "
    }
    return indent
}
