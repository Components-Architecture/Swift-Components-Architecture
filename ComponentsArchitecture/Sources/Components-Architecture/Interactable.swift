//
//  File.swift
//  Swift-Components-Architecture
//
//  Created by wimes on 10/31/25.
//

import Foundation

public protocol ExternalActionable: Sendable {
  associatedtype External
  
  static func external(_ action: External) -> Self
}

@MainActor
public protocol Interactable: AnyObject, ObservableObject {
  associatedtype State
  associatedtype Action: Sendable
  associatedtype Mutation: Sendable
  
  var state: State { get set }
  
  func send(_ action: Action)
  func transform(_ action: Action) -> Flow<Action>
  func mutate(action: Action) async -> Flow<Mutation>
  func reduce(state: State, mutation: Mutation) -> State
}

public extension Interactable {
  func transform(_ action: Action) -> Flow<Action> {
    return .just(action)
  }
  
  func send(_ action: Action) {
    Task { [weak self] in
      guard let self else { return }
      
      var mutations: Flow<Mutation> = .none
      
      for await transform in self.transform(action) {
        mutations = await self.mutate(action: transform)
      }
      
      for await mutation in mutations {
        let newState = reduce(state: self.state, mutation: mutation)
        self.state = newState
      }
    }
  }
}

public extension Interactable where Action: ExternalActionable {
  func sendExternal(_ action: Action.External) {
    send(.external(action))
  }
}

// MARK: - Hashable

public extension Interactable where Self: Hashable {
  nonisolated static func == (lhs: Self, rhs: Self) -> Bool {
    lhs === rhs
  }
  
  nonisolated func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
}
