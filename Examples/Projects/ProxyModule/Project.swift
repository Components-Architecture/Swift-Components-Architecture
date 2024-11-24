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

let project = ExampleModule.proxyModule
    .makeModule(
        packages: [
            .local(path: .relativeToRoot("../ComponentsArchitecture")),
        ],
        dependencies: [
            .package(product: "ComponentsArchitecture"),
        ],
        settings: settings
    )
