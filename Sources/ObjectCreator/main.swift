import Foundation
import Commander
import Files

let filenameArgument = Argument<String>("input", description: "file containing json payload")

func execute(for filename: String) throws {
    
    print("Filename: \(filename)")
    
    let file = try Folder.current.file(atPath: filename)
    let jsonContents = try file.readAsString()
    
    let creator = try ObjectCreator(
        jsonString: jsonContents,
        topLevelObjectName: "ReportProblemInfo"
    )
    
    let objects = creator.export()
    print(objects)
}

let app = command(filenameArgument, execute)
app.run()
