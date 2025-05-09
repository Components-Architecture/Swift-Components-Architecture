//
//  Project.swift
//  AppManifests
//
//  Created by Gihyun on 11/24/24.
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

let project = ExampleModule.Feature.counter(.impl)
  .makeModule(
    dependencies: [
      .Example.Module(.proxyModule),
      .Example.Feature(.counter(.interface)),
    ],
    settings: settings
  )
