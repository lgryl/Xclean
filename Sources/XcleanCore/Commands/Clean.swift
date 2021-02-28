// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Clean: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Removes content of selected location"
        )
        @Argument(help: ArgumentHelp("The location to be cleaned", discussion: Location.availableLocationsDescription, valueName: "location"))

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
                let result = try shellOut(to: "rm -r", arguments: ["\(location.path)/*"])
                print(result)
            } catch {
                print(error)
            }
        }
    }
}
