// Created 28/02/2021

import Foundation

extension String {
    var escapingSpaces: String {
        replacingOccurrences(of: " ", with: "\\ ")
            .replacingOccurrences(of: "(", with: "\\(")
            .replacingOccurrences(of: ")", with: "\\)")
    }
}
