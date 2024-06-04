// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "AuthService",
    products: [
        .library(
            name: "AuthService",
            targets: ["AuthService"]),
    ],
    targets: [
        .target(
            name: "AuthService"
        )
    ]
)
