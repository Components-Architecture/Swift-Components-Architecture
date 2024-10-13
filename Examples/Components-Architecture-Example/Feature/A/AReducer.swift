//
//  AReducer.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import Foundation

actor AReducer: Reducer {
  struct State {
    var number: Int = 0
  }

  enum Action {
    case didTapMinus
    case didTapPlus
  }

  let initialState: State

  init(initialState: State) {
    self.initialState = initialState
  }

  func reduce(state: State, action: Action) async -> State {
    var newState = state

    switch action {
    case .didTapMinus:
      newState.number = state.number - 1
    case .didTapPlus:
      newState.number = state.number + 1
    }

    return newState
  }
}
