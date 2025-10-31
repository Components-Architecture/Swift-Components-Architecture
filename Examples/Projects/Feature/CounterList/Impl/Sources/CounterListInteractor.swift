//
//  CounterListInteractor.swift
//  CounterListImpl
//
//  Created by wimes on 10/31/25.
//  Copyright © 2025 ComponentsArchitecture. All rights reserved.
//

import Foundation
import ComponentsArchitecture

public final class CounterListInteractor: Interactable, Hashable {
  public struct State {
    var items: [ItemInteractor] = []
    
    public init() {

    }
  }
  
  public enum Action: ExternalActionable {
    public enum External: Sendable {
      
    }
    
    case onAppear
    case didTapIncreaseOdd
    
    case external(_ action: External)
  }
  
  public enum Mutation: Sendable {
    case setItems([ItemInteractor])
  }
  
  @Published
  public var state: State
  
  public init(initialState: State) {
    self.state = initialState
  }
  
  public func mutate(action: Action) async -> Flow<Mutation> {
    switch action {
    case .onAppear:
      return .just(.setItems([
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init()),
        .init(initialState: .init())
      ]))
    case .didTapIncreaseOdd:
      self.state.items.enumerated().forEach {
        if $0.offset % 2 == 1 {
          $0.element.sendExternal(.increase)
        }
      }
      return .none
    case .external:
      return .none
    }
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case .setItems(let items):
      newState.items = items
    }
    
    return newState
  }
  
  
}
