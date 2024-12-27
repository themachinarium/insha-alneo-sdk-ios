// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlneoAPIClient",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "AlneoAPIClient",
            targets: ["AlneoAPIClient"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.8.3")),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "4.0.0"),
        .package(url: "https://github.com/datatheorem/TrustKit.git", .upToNextMajor(from: "3.0.5"))
    ],
    targets: [
        .target(
            name: "AlneoAPIClient",
            dependencies: [
                "CryptoSwift",
                "SwiftyJSON",
                "TrustKit"
            ],
            path: "Sources/AlneoAPIClient", // Specify the path to the AlneoAPIClient folder
            exclude: [] // Include any files you wish to exclude, if any
        ),
    ]
    
//    products: [
//        // Products define the executables and libraries a package produces, making them visible to other packages.
//        .library(
//            name: "AlneoAPIClient",
//            targets: ["AlneoAPIClient"]),
//    ],
//    targets: [
//        // Targets are the basic building blocks of a package, defining a module or a test suite.
//        // Targets can depend on other targets in this package and products from dependencies.
//        .target(
//            name: "AlneoAPIClient"),
//
//    ]
)
