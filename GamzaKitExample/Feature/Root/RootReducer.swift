//
//  RootReducer.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/3/24.
//

import Foundation

actor RootReducer: Reducer {
  struct State {
    var number: Int = 0
  }
  
  enum Action {
    case didTapMinus
    case didTapPlus
  }
  
  let initialState: State
  
  var state: State
  
  init(initialState: State) {
    self.initialState = initialState
    self.state = initialState
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
