//
//  Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by Wimes on 2023/09/17.
//

import ProjectDescription

public enum Environment {
    public static let appName: String = "ComponentsArchitecture-Example"
    public static let bundleID: String = "app.example.ca"
    public static let targetName: String = "ComponentsArchitecture"
    public static let organizationName: String = "ComponentsArchitecture"
    public static let deploymentTargets: DeploymentTargets = .iOS("15.0")
    public static let destinations: Destinations = [.iPhone]
}
