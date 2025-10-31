//
//  ExampleModule.swift
//  ProjectDescriptionHelpers
//
//  Created by Milkyo on 12/30/23.
//

import Foundation
import ProjectDescription

public enum ExampleModule: String {
  case proxyModule

  public enum Feature {
    case counterList(TargetDependencyType)

    var rawValue: String {
      switch self {
      case .counterList:
        "CounterList"
      }
    }

    public var name: String {
      switch self {
      case let .counterList(type):
        self.rawValue + type.rawValue
      }
    }

    var path: Path {
      switch self {
      case let .counterList(type):
        _path(type)
      }
    }

    private func _path(_ type: TargetDependencyType) -> Path {
      .relativeToFeature(rawValue, type: type)
    }
  }

  public var name: String {
    switch self {
    case .proxyModule:
      "ProxyModule"
    }
  }

  var path: Path {
    .relativeToRoot("Projects/\(name)")
  }
}
