// swift-tools-version: 6.2
// Copyright Ryan Francesconi. All Rights Reserved. Revision History at https://github.com/ryanfrancesconi/spfk-webp

import PackageDescription

let package = Package(
    name: "spfk-webp",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "SPFKWebP",
            targets: ["SPFKWebP"]
        ),
        .library(
            name: "libwebp",
            targets: ["libwebp"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ryanfrancesconi/spfk-base", from: "1.10.0"),
        .package(url: "https://github.com/ryanfrancesconi/spfk-image", from: "0.1.0"),
        .package(url: "https://github.com/ryanfrancesconi/spfk-testing", from: "1.10.0"),
    ],
    targets: [
        .target(
            name: "libwebp",
            publicHeadersPath: "src/webp",
            cSettings: [
                .headerSearchPath("."),
                // Without it the encoder's thread_level setting does nothing.
                .define("WEBP_USE_THREAD"),
            ]
        ),
        .target(
            name: "SPFKWebP",
            dependencies: [
                "libwebp",
                .product(name: "SPFKImage", package: "spfk-image"),
            ]
        ),
        .testTarget(
            name: "SPFKWebPTests",
            dependencies: [
                "SPFKWebP",
                .product(name: "SPFKBase", package: "spfk-base"),
                .product(name: "SPFKImage", package: "spfk-image"),
                .product(name: "SPFKTesting", package: "spfk-testing"),
            ]
        ),
    ]
)
