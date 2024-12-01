//
//  Project.swift
//  ExamplesManifests
//
//  Created by Gihyun on 11/24/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let name: String = Environment.appName
private let platform: Platform = .iOS
private let product: Product = .app
private let organizationName: String = Environment.organizationName
private let deploymentTargets: DeploymentTargets = Environment.deploymentTargets
private let infoPlist: InfoPlist = .default
private let sources: SourceFilesList = ["Sources/**"]
private let resources: ResourceFileElements = ["Resources/**"]
private let scripts: [TargetScript] = []
private let dependencies: [TargetDependency] = [
  .Example.Module(.proxyModule),
  .Example.Feature(.counter(.interface)),
  .Example.Feature(.counter(.impl)),
  .Example.Feature(.counterDetail(.interface)),
  .Example.Feature(.counterDetail(.impl)),
]
private let settings: Settings = .settings(
  base: [
    "SWIFT_VERSION": "6.0",
  ],
  configurations: [
    .debug(name: .debug),
  ],
  defaultSettings: .recommended
)

private let appTarget = Target
  .target(
    name: name,
    destinations: Environment.destinations,
    product: product,
    bundleId: Environment.bundleID,
    deploymentTargets: deploymentTargets,
    infoPlist: infoPlist,
    sources: sources,
    resources: resources,
    scripts: scripts,
    dependencies: dependencies,
    settings: settings
  )

let project: Project = .init(
  name: Environment.appName,
  organizationName: organizationName,
  options: .options(developmentRegion: "ko"),
  settings: settings,
  targets: [appTarget],
  schemes: []
)
