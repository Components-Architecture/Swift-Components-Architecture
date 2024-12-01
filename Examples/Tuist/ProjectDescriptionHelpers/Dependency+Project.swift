//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by Wimes on 2023/09/16.
//

import ProjectDescription

// MARK: - Dependency 분리 (모듈 레이어 정의)

public enum TargetDependencyType: String {
  case impl = "Impl"
  case interface = "Interface"
}

extension TargetDependency {
  public enum Example {
    public static func Feature(_ feature: ExampleModule.Feature) -> TargetDependency {
      .project(target: feature.name, path: feature.path)
    }

    public static func Module(_ module: ExampleModule) -> TargetDependency {
      .project(target: module.name, path: module.path)
    }
  }
}
