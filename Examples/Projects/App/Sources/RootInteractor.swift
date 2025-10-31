//
//  RootInteractor.swift
//  ComponentsArchitecture-Example
//
//  Created by wimes on 10/31/25.
//  Copyright © 2025 ComponentsArchitecture. All rights reserved.
//

import Foundation
import CounterListInterface
import CounterListImpl
import ComponentsArchitecture

final class RootInteractor: Interactable {
  public struct State {
    public enum Path: Hashable {
      case counterList(CounterListInteractor)
    }
    
    var paths: [Path] = []
  }
  
  public enum Action {
    case onAppear
    case didTapRootView
  }
  
  public enum Mutation: Sendable {
    case setPaths(paths: [State.Path])
  }
  
  @Published
  public var state: State
  
  public init(initialState: State) {
    self.state = initialState
  }
  
  public func mutate(action: Action) async -> Flow<Mutation> {
    switch action {
    case .onAppear:
      return .none
      
    case .didTapRootView:
      return .just(
        .setPaths(paths: [
          .counterList(.init(initialState:.init()))
        ])
      )
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .setPaths(let paths):
      newState.paths = paths
    }
    return newState
  }
}
