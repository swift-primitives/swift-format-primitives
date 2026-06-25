// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-format-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Format Primitive",
            targets: ["Format Primitive"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Format Case Primitives",
            targets: ["Format Case Primitives"]
        ),
        .library(
            name: "Format Decimal Primitives",
            targets: ["Format Decimal Primitives"]
        ),
        .library(
            name: "Format Numeric Primitives",
            targets: ["Format Numeric Primitives"]
        ),

        // MARK: - StdLib Integration
        .library(
            name: "Format Primitives Standard Library Integration",
            targets: ["Format Primitives Standard Library Integration"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Format Primitives",
            targets: ["Format Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Format Primitives Test Support",
            targets: ["Format Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-standard-library-extensions.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-formatter-primitives.git", branch: "main"),
        // SDG(produces): formatting produces string output
        // .package(url: "https://github.com/swift-primitives/swift-string-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Namespace
        .target(
            name: "Format Primitive",
            dependencies: []
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        .target(
            name: "Format Case Primitives",
            dependencies: [
                "Format Primitive",
                .product(name: "Formatter Primitives", package: "swift-formatter-primitives"),
            ]
        ),
        .target(
            name: "Format Decimal Primitives",
            dependencies: [
                "Format Primitive",
                .product(name: "Standard Library Extensions", package: "swift-standard-library-extensions"),
            ]
        ),
        .target(
            name: "Format Numeric Primitives",
            dependencies: [
                "Format Primitive",
            ]
        ),

        // MARK: - StdLib Integration
        .target(
            name: "Format Primitives Standard Library Integration",
            dependencies: [
                "Format Primitive",
                "Format Case Primitives",
                "Format Decimal Primitives",
                .product(name: "Formatter Primitives", package: "swift-formatter-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Format Primitives",
            dependencies: [
                "Format Primitive",
                "Format Case Primitives",
                "Format Decimal Primitives",
                "Format Numeric Primitives",
                "Format Primitives Standard Library Integration",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Format Primitives Test Support",
            dependencies: [
                "Format Primitives",
                .product(name: "Tagged Primitives Test Support", package: "swift-tagged-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Formatting Primitives Tests",
            dependencies: [
                "Format Primitives",
                "Format Primitives Test Support",
                .product(name: "Formatter Primitives", package: "swift-formatter-primitives"),
            ],
            path: "Tests/Format Primitives Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
