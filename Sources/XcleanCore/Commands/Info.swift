// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Info: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Prints info about disk usage"
        )
        @Argument(help: ArgumentHelp("The location to be displayed info about", discussion: Location.availableLocationsDescription, valueName: "location"))
        var location: Location
        

        public func validate() throws {
            do {
                _ = try Folder(path: location.path)
            } catch {
                throw ValidationError("Path doesn't exist")
            }
        }

        public func run() {
            do {
                let result = try shellOut(to: "du -hs \(location.path.escapingSpaces) | cut -f1")
                print(result)
            } catch {
                print("Error")
            }
        }
    }
}
