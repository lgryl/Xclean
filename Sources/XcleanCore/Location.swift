// Created 24/02/2021

import Foundation
import ArgumentParser

enum Location: String, CaseIterable {
    case derivedData
    case deviceSupport

    var path: String {
        switch self {
        case .derivedData:
            return "~/Library/Developer/Xcode/DerivedData"
        case .deviceSupport:
            return "~/Library/Developer/Xcode/iOS DeviceSupport"
        }
    }
}

extension Location: ExpressibleByArgument {
    init?(argument: String) {
        self.init(rawValue: argument)
    }
}

extension Location {
    static var availableLocations: String {
        Location.allValueStrings.joined(separator: "\n")
    }

    static var availableLocationsDescription: String {
        "AvailableLocations:\n" + availableLocations
    }
}
