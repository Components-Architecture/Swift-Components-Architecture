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
    case counter(TargetDependencyType)
    case counterDetail(TargetDependencyType)

    var rawValue: String {
      switch self {
      case .counter:
        "Counter"
      case .counterDetail:
        "CounterDetail"
      }
    }

    public var name: String {
      switch self {
      case let .counter(type):
        "Counter" + type.rawValue
      case let .counterDetail(type):
        "CounterDetail" + type.rawValue
      }
    }

    var path: Path {
      switch self {
      case let .counter(type):
        _path(type)
      case let .counterDetail(type):
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
