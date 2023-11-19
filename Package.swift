// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "feather-mail-driver-ses",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "FeatherMailDriverSES", targets: ["FeatherMailDriverSES"]),
//        .library(name: "SotoSESv2", targets: ["SotoSESv2"]),
    ],
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-mail.git", .upToNextMinor(from: "0.1.0")),
        .package(url: "https://github.com/soto-project/soto-core", from: "6.5.0"),
        .package(url: "https://github.com/soto-project/soto", from: "6.8.0"),
//        .package(url: "https://github.com/soto-project/soto-codegenerator", from: "0.8.0"),
    ],
    targets: [
//        .target(
//            name: "SotoSESv2",
//            dependencies: [
//                .product(name: "SotoCore", package: "soto-core"),
//            ],
//            plugins: [
//                .plugin(
//                    name: "SotoCodeGeneratorPlugin",
//                    package: "soto-codegenerator"
//                ),
//            ]
//        ),
        .target(
            name: "FeatherMailDriverSES",
            dependencies: [
                .product(name: "FeatherMail", package: "feather-mail"),
                .product(name: "SotoSESv2", package: "soto"),
                .product(name: "SotoCore", package: "soto-core"),
//                .target(name: "SotoSESv2"),
            ]
        ),
        .testTarget(
            name: "FeatherMailDriverSESTests",
            dependencies: [
                .product(name: "FeatherMail", package: "feather-mail"),
                .product(name: "XCTFeatherMail", package: "feather-mail"),
                .target(name: "FeatherMailDriverSES"),
            ]
        ),
    ]
)
