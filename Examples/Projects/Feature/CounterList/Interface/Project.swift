//
//  Project.swift
//  AppManifests
//
//  Created by wimes on 10/31/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let settings: Settings = .settings(
  base: [
    "SWIFT_VERSION": "6.0",
  ],
  configurations: [
    .debug(name: .debug),
  ],
  defaultSettings: .recommended
)

let project = ExampleModule.Feature.counterList(.interface)
  .makeModule(
    dependencies: [
      .Example.Module(.proxyModule),
    ],
    settings: settings
  )

