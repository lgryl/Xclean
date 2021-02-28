// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Open: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Opens selected location in Finder"
        )
        @Argument(help: ArgumentHelp("The location to be opened", discussion: Location.availableLocationsDescription, valueName: "location"))
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
                _ = try shellOut(to: "open", arguments: ["\(location.path.escapingSpaces)"])
            } catch {
                print(error)
            }
        }
    }
}
