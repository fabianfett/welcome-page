// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "welcome",
    platforms: [.macOS(.v14)],
    products: [
        .executable(
            name: "welcome",
            targets: ["Welcome"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-alpha"),
        .package(url: "https://github.com/robb/Swim.git", from: "0.4.0")
    ],
    targets: [
        .executableTarget(
            name: "Welcome",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HTML", package: "Swim"),
            ]
        ),
        .testTarget(
            name: "WelcomeTests",
            dependencies: ["Welcome"]),
    ]
)
