// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnapshotSafeView",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "SnapshotSafeView", targets: ["SnapshotSafeView"])
    ],
    targets: [
        .target(name: "SnapshotSafeView", dependencies: []),
        .testTarget(name: "SnapshotSafeViewTests", dependencies: ["SnapshotSafeView"]),
    ]
)

