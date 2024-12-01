//
//  Path+.swift
//  ProjectDescriptionHelpers
//
//  Created by Wimes on 2023/09/16.
//

import ProjectDescription

extension Path {
  public static func relativeToFeature(_ name: String, type: TargetDependencyType) -> Self {
    .relativeToRoot("Projects/Feature/\(name)/\(type.rawValue)")
  }
}
