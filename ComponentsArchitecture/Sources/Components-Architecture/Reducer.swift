//
//  Reducer.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

enum StateStore {
  static let currentState = MapTable<AnyObject, Sendable>()
}

public protocol Reducer: AnyObject, Sendable, Hashable {
  associatedtype State: Sendable
  associatedtype Action: Sendable

  var initialState: State { get }
  
  func reduce(state: State, action: Action) async -> State
}

public extension Reducer {
  var currentState: State {
    get async {
      return (await StateStore.currentState.getValue(forKey: self) as? State) ?? self.initialState
    }
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
  
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.hashValue == rhs.hashValue
  }
}
