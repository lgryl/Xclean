// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Open: ParsableCommand {
        @Argument(help: "The path")
        var location: Location

        public func validate() throws {
            do {
                _ = try Folder(path: location.path)
            } catch {
                throw ValidationError("Path doesn't exist")
            }
        }

        public func run() {
            _ = try? shellOut(to: "open \(location.path)")
        }
    }
}

enum Location: String {
    case derivedData

    var path: String {
        switch self {
        case .derivedData:
            return "~/Library/Developer/Xcode/DerivedData"
        }
    }
}

extension Location: ExpressibleByArgument {
    init?(argument: String) {
        self.init(rawValue: argument)
    }
}
