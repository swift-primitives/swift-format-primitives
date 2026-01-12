// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "swift-formatting-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Formatting Primitives",
            targets: ["Formatting Primitives"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-standard-library-extensions.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-identity-primitives.git", from: "0.0.1"),
        .package(url: "https://github.com/swift-primitives/swift-test-primitives.git", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "Formatting Primitives",
            dependencies: [
                .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions"),
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
            ]
        ),
        .testTarget(
            name: "Formatting Primitives Tests",
            dependencies: [
                "Formatting Primitives",
                .product(name: "Test Primitives", package: "swift-test-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
