import Foundation
import Commander
import Files

let filenameArgument = Argument<String>("input", description: "file containing json payload")
let objectNameArgument = Option("name", default: "Object", description: "The name of the top-level argument")

func execute(for filename: String, name: String) throws {
    
    let file = try Folder.current.file(atPath: filename)
    let jsonContents = try file.readAsString()
    
    let creator = try ObjectCreator(
        jsonString: jsonContents,
        topLevelObjectName: name
    )
    
    let objects = creator.export()
    print(objects)
}

let app = command(filenameArgument, objectNameArgument, execute)
app.run()
