//
//  RootReducer.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterDetailImpl
import CounterDetailInterface
import CounterInterface
import CounterImpl
import Foundation

actor RootReducer: Reducer {
  struct State {
    enum Brand {
      case gamzabada
      case estelle
    }
    
    let barnd: Brand = .gamzabada
  }

  enum Action {
    case onAppear
    case counterDetailDidTapText
  }

  let initialState: State
  
  init(initialState: State) {
    self.initialState = initialState
  }

  func reduce(state: State, action: Action) async -> State {
    let newState = state
    
    return newState
  }
}
