// Created 24/02/2021

import Foundation
import ArgumentParser
import ShellOut
import Files

extension Xclean {
    struct Clean: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Remove content of selected location"
        )
        @Argument(help: ArgumentHelp("The location to be cleaned", discussion: Location.availableLocationsDescription, valueName: "location"))
        var location: Location

        @Flag(name: .shortAndLong, help: "Run interactive clean")
        var interactive = false

        public func validate() throws {
            do {
                let folder = try Folder(path: location.path)
                guard folder.subfolders.count() + folder.files.count() > 0 else {
                    throw ValidationError("Folder is empty")
                }
            } catch is LocationError {
                throw ValidationError("Path doesn't exist")
            }

        }

        public func run() throws {
            if interactive {
                try interactiveClean()
            } else {
                try clean()
            }
        }

        private func interactiveClean() throws {
            let folder = try Folder(path: location.path)
            repeat {
                let subItems = folder.subfolders.map { (name: $0.name, path: $0.path) } + folder.files.map { (name: $0.name, path: $0.path) }

                for (index, item) in subItems.enumerated() {
                    print(item.path)
                    let escapedPath = item.path.escapingSpaces
                    let output = try shellOut(to: "du -hs \(escapedPath)")
                    print("\(index + 1))\t\(output)\t\t")
                }

                print("Type a number corresponding to a folder you wish to delete.")
                print("Type 'q' to quit.")
                print("Press Enter to confirm your choice.")

                guard let choice = readLine() else {
                    print("No choice")
                    continue
                }
                switch (choice, Int(choice)) {
                case ("q", _):
                    return
                case (_, let number?) where number > 0 && number < subItems.count:
                    try shellOut(to: "rm -rf \(subItems[number - 1].path)", at: folder.path)
                default:
                    print("Invalid choice")
                }

            } while true
        }

        private func clean() throws {
            let result = try shellOut(to: "rm -r", arguments: ["\(location.path)/*"])
            print(result)
        }
    }
}
