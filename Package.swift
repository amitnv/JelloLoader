// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JelloLoader",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "JelloLoader",
            targets: ["JelloLoader"]),
    ],
    dependencies: [
        .package(url: "https://github.com/InderKumarRathore/DeviceGuru", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "JelloLoader",
            dependencies: ["DeviceGuru"]),
    ]
)
