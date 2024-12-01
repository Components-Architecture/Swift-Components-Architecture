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

public protocol Reducer: AnyObject, Sendable {
  associatedtype State: Sendable
  associatedtype Action: Sendable

  var initialState: State { get }
  
  func reduce(state: State, action: Action) async -> State
}
extension Reducer {
  public var currentState: State {
    get async {
      return (await StateStore.currentState.getValue(forKey: self) as? State) ?? self.initialState
    }
  }
}
