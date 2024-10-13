// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Swift-Components-Architecture",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "ComponentsArchitecture",
      targets: ["ComponentsArchitecture"]
    ),
  ],
  targets: [
    .target(
      name: "ComponentsArchitecture"),
  ],
  swiftLanguageModes: [.v6]
)
