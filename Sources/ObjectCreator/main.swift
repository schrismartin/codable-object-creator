import Foundation
import Commander
import Files

typealias Args = Constants.Arguments

func execute(for filename: String, name: String, directory: String, shouldPrint: Bool, isDebugMode: Bool) throws {
    
    let arguments = Arguments(
        filename: filename,
        name: name,
        directory: directory,
        shouldPrint: shouldPrint,
        isDebugMode: isDebugMode
    )
    
    let app = App(args: arguments)
    try app.execute()
}

let commandLineExecutor = command(Args.source, Args.objectName, Args.directory, Args.print, Args.debug, execute)
commandLineExecutor.run()
