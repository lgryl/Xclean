import Foundation
import ArgumentParser
import ShellOut

public struct Xclean: ParsableCommand {
    public static let configuration = CommandConfiguration(
        abstract: "Cleans up",
        subcommands: [Open.self]
    )

    public init() {}
}
