// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Info: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Print info about disk usage"
        )
        @Argument(help: ArgumentHelp("The location to be displayed info about", discussion: Location.availableLocationsDescription, valueName: "location"))
        var location: Location
        @Flag(name: .shortAndLong, help: "Show combined disk usage from all subfolders")
        var combined = false

        public func validate() throws {
            do {
                _ = try Folder(path: location.path)
            } catch {
                throw ValidationError("Path doesn't exist")
            }
        }

        public func run() {
            do {
                var command = "du -hs \(location.path.escapingSpaces)"
                if combined {
                    command += " | cut -f1"
                } else {
                    command += "/* | sort -rh"
                }
                let result = try shellOut(to: command)
                print(result)
            } catch {
                print("Error")
            }
        }
    }
}
