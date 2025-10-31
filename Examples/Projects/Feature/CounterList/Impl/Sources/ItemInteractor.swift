//
//  ItemInteractor.swift
//  CounterListImpl
//
//  Created by wimes on 10/31/25.
//  Copyright © 2025 ComponentsArchitecture. All rights reserved.
//

import Foundation
import ComponentsArchitecture

public final class ItemInteractor: Interactable, Hashable {
  public struct State {
    public enum BackGroundColor: Sendable {
      case red
      case white
    }
    
    var count: Int = 0
    var backgroundColor: BackGroundColor = .white
  }
  
  public enum Action: ExternalActionable {
    public enum External: Sendable {
      case increase
    }
    case external(_ action: External)
    
    case onAppear
    case didTapButton
  }
  
  public enum Mutation: Sendable {
    case setCount(Int)
    case setBackgroundColor(State.BackGroundColor)
  }
  
  @Published
  public var state: State
  
  init(initialState: State) {
    self.state = initialState
  }
  
  public func mutate(action: Action) async -> Flow<Mutation> {
    switch action {
    case .external(let action):
      return self.external(action)
      
    case .onAppear:
      return .concatenate(
        .just(.setBackgroundColor(.white)),
        .just(.setCount(0)),
      )
    case .didTapButton:
      return .concatenate(
        .just(.setCount(self.state.count + 1)),
        .just(.setBackgroundColor(.white))
      )
    }
  }
  
  private func external(_ action: Action.External) -> Flow<Mutation> {
    switch action {
    case .increase:
      return .concatenate(
        .just(.setCount(self.state.count + 1)),
        .just(.setBackgroundColor(.red))
      )
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setCount(let count):
      newState.count = count
    case .setBackgroundColor(let backGroundColor):
      newState.backgroundColor = backGroundColor
    }
    
    return newState
  }
}
