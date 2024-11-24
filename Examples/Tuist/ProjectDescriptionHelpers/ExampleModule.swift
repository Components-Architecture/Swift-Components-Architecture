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
                return "Counter"
            case .counterDetail:
                return "CounterDetail"
            }
        }

        public var name: String {
            switch self {
            case let .counter(type):
                return "Counter" + type.rawValue
            case let .counterDetail(type):
                return "CounterDetail" + type.rawValue
            }
        }

        var path: Path {
            switch self {
            case let .counter(type):
                return _path(type)
            case let .counterDetail(type):
                return _path(type)
            }
        }

        private func _path(_ type: TargetDependencyType) -> Path {
            .relativeToFeature(rawValue, type: type)
        }
    }

    public var name: String {
        switch self {
        case .proxyModule:
            return "ProxyModule"
        }
    }

    var path: Path {
        .relativeToRoot("Projects/\(name)")
    }
}
