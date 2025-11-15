// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AuthService",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AuthService",
            targets: ["AuthService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/silentcrewtechnology/iOS.Extensions.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/silentcrewtechnology/iOS.Services.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "AuthService",
            dependencies: [
                .product(name: "Extensions", package: "ios-extensions"),
                .product(name: "Services", package: "ios-services"),
            ]
        )
    ]
)
