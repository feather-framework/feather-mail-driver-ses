# Feather Mail Driver SES

A mail driver for the Feather CMS mail component using AWS SES.

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-mail-driver-ses", .upToNextMinor(from: "0.2.0")),
```

and to your application target, add `FeatherMailDriverSES` to your dependencies:

```swift
.product(name: "FeatherMailDriverSES", package: "feather-mail-driver-ses")
```

Example `Package.swift` file with `FeatherMailDriverSES` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-mail-driver-ses.git", .upToNextMinor(from: "0.2.0")),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherMailDriverSES", package: "feather-mail-driver-ses")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

###  Using FeatherMailDriverSES

See the `FeatherMailDriverSESTests` target for a basic implementation.

See developer documentation here:
[Documentation](https://feather-framework.github.io/feather-mail-diver-ses/documentation/feathermaildriverses)
