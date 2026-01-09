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
        .package(path: "../swift-standard-library-extensions"),
        .package(path: "../swift-identity-primitives"),
        .package(path: "../swift-test-support-primitives"),
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
                .product(name: "Test Support Primitives", package: "swift-test-support-primitives"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)
