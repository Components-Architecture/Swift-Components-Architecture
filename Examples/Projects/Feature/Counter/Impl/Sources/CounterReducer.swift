//
//  CounterReducer.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import Foundation
import CounterInterface

public actor CounterReducer: Reducer {
  public struct State: Sendable {
    public var number: Int {
      didSet {
        print("##")
      }
    }
    public init(number: Int) {
      self.number = number
    }
  }

  public enum Action: Sendable {
    case didTapMinus
    case didTapPlus
    case didTapNumber((@Sendable (Int) async -> Void)?)
  }

  public let initialState: State
  
  public init(initialState: State) {
    self.initialState = initialState
  }

  public func reduce(state: State, action: Action) async -> State {
    var newState = state

    switch action {
    case .didTapMinus:
      newState.number = state.number - 1
      
    case .didTapPlus:
      newState.number = state.number + 1
      
    case .didTapNumber(let function):
      await function?(state.number)
    }

    return newState
  }
}
