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
        .package(url: "https://gitlab.akbars.tech/abo/ios-service-network", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://gitlab.akbars.tech/abo/ios-extensions.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://gitlab.akbars.tech/abo/ios-services", .upToNextMajor(from: "0.3.0")),
    ],
    targets: [
        .target(
            name: "AuthService",
            dependencies: [
                .product(name: "iOS.Service.Network", package: "ios-service-network"),
                .product(name: "Extensions", package: "ios-extensions"),
                .product(name: "Services", package: "ios-services"),
            ]
        )
    ]
)
