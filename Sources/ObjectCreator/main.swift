import Foundation
import Commander
import Files

let sourceArgument = Argument<String>(
    "source",
    description: "file containing json payload"
)

let objectNameArgument = Argument<String>(
    "name",
    description: "name of top-level object"
)

let directoryArgument = Option(
    "dir",
    default: Constants.defaultOutputDirectory,
    description: "Output directory to write resulting files"
)

let printArgument = Flag(
    "print",
    default: false,
    flag: "p",
    description: "Print resulting file contents to the console"
)

let debugArgument = Flag(
    "debug",
    default: false,
    flag: "d",
    description: "Print debug information to the console"
)

func execute(for filename: String, name: String, directory: String, shouldPrint: Bool, isDebugMode: Bool) throws {
    
    if isDebugMode {
        print("source: \(filename), name: \(name), dir: \(directory), shouldPrint: \(shouldPrint)")
    }
    
    let file = try Folder.current.file(atPath: filename)
    let jsonContents = try file.readAsString()
    
    let creator = try ObjectCreator(
        jsonString: jsonContents,
        topLevelObjectName: name
    )
    
    if shouldPrint {
        
        let stringObjects = creator.export()
        print(stringObjects)
    }
    
    if !shouldPrint || directory != Constants.defaultOutputDirectory {
        
        let folder = try Folder.current.createSubfolderIfNeeded(withName: directory)
        let objects = creator.objects
        try write(objects: objects, to: folder)
    }
}

func write(objects: [Object], to folder: Folder) throws {
    
    for object in objects {
        
        let filename = "\(object.className).swift"
        let file = try folder.createFileIfNeeded(withName: filename)
        try file.write(string: object.formatted)
    }
}

let app = command(sourceArgument, objectNameArgument, directoryArgument, printArgument, debugArgument, execute)
app.run()
