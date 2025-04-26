//
//  File.swift
//  Swift-Components-Architecture
//
//  Created by wimes on 4/26/25.
//

import Foundation
public protocol Routable: ObservableObject {
  associatedtype Route: Hashable
  var paths: [Route] { get set }
  
  func push(route: Route)
  func pop()
  func setPaths(_ paths: [Route])
  func popToRoot()
}

public extension Routable {
  // TODO: (wimes) present, dismiss 구현
  // TODO: (wimes) 각 메서드 compleiton(async/await) 구현
  
  func push(route: Route) {
    self.paths.append(route)
  }
  
  func pop() {
    self.paths.removeLast()
  }
  
  func setPaths(_ paths: [Route]) {
    self.paths = paths
  }
  
  func popToRoot() {
    self.paths = []
  }
}
