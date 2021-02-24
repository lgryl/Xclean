// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Xclean",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(url: "https://github.com/johnsundell/files.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "Xclean",
            dependencies: ["XcleanCore"]),
        .target(
            name: "XcleanCore",
            dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "XcleanTests",
            dependencies: ["Xclean"]),
    ]
)
