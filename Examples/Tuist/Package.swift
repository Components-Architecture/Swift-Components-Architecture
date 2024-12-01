// swift-tools-version: 5.9
@preconcurrency import PackageDescription

#if TUIST
  @preconcurrency import ProjectDescription
  import ProjectDescriptionHelpers

  let packageSettings = PackageSettings(productTypes: [:])
#endif

let package = Package(
  name: "ComponentsArchitecturePackage",
  platforms: [.iOS(.v15)],
  dependencies: []
)
