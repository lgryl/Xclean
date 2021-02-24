import Foundation

public final class Xclean {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        print("Hello \(arguments[1])")
    }
}
