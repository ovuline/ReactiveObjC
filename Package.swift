// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ReactiveObjC",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "ReactiveObjC", targets: ["ReactiveObjC"])
    ],
    targets: [
        .target(
            name: "ReactiveObjC",
            path: "ReactiveObjC",
            exclude: ["Exclude"],
            sources: ["Sources"],
            publicHeadersPath: "Headers/Public"
        )
    ]
)
