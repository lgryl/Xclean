import Foundation
import ArgumentParser
import ShellOut

public struct Xclean: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Utility to help you clean up Xcode files",
        subcommands: [Open.self, Info.self, Clean.self]
    )

    public init() {}
}
