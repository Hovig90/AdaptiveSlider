// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdaptiveSlider",
	platforms: [
		.iOS(.v16)
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AdaptiveSlider",
            targets: ["AdaptiveSlider"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AdaptiveSlider",
			swiftSettings: [
				.enableUpcomingFeature("StrictConcurrency")
			  ]
		),
		.target(
			name: "AdaptiveSliderPreviews",
			dependencies: ["AdaptiveSlider"],
			path: "Sources/AdaptiveSliderPreviews",
			swiftSettings: [
				.define("DEBUG"),
				.enableUpcomingFeature("StrictConcurrency")
			  ]
		),
        .testTarget(
            name: "AdaptiveSliderTests",
            dependencies: ["AdaptiveSlider"],
			swiftSettings: [
				.enableUpcomingFeature("StrictConcurrency")
			  ]
		)
    ]
)
