//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Wimes on 2023/09/16.
//

import ProjectDescription

public protocol ProjectConfigurable {
  var name: String { get }
  func makeModule(
    packages: [Package],
    dependencies: [TargetDependency],
    resources: ResourceFileElements?,
    settings: Settings,
    product: Product,
    infoPlist: InfoPlist,
    scripts: [TargetScript]
  ) -> Project
}

extension ProjectConfigurable {
  public func makeModule(
    packages: [Package] = [],
    dependencies: [TargetDependency] = [],
    resources: ResourceFileElements? = nil,
    settings: Settings,
    product: Product = .framework,
    infoPlist: InfoPlist = .default,
    scripts: [TargetScript] = []
  ) -> Project {
    guard product == .framework ||
      product == .staticFramework ||
      product == .dynamicLibrary ||
      product == .staticLibrary
    else { fatalError("module을 만들때는 product가 framework 또는 library여야 합니다.") }

    let bundleID = Environment.bundleID

    var targets: [Target] = []
    var schemes: [Scheme] = []

    let target: Target = .target(
      name: name,
      destinations: Environment.destinations,
      product: product,
      bundleId: "\(bundleID).\(name)",
      deploymentTargets: Environment.deploymentTargets,
      infoPlist: infoPlist,
      sources: ["Sources/**"],
      resources: resources,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings
    )
    targets.append(target)

    return .init(
      name: name,
      organizationName: Environment.organizationName,
      packages: packages,
      settings: settings,
      targets: targets,
      schemes: schemes
    )
  }
}

extension ExampleModule.Feature: ProjectConfigurable {}
extension ExampleModule: ProjectConfigurable {}
