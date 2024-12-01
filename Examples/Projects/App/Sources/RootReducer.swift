//
//  RootReducer.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterDetailImpl
import CounterDetailInterface
import Foundation

actor RootReducer: Reducer {
  struct State {
    enum Brand {
      case gamzabada
      case estelle
    }

    let barnd: Brand = .gamzabada
    var counterDetailInteractor: CounterDetailReducer?
  }

  enum Action {
    case onAppear
    case didTapText
  }

  let initialState: State

  init(initialState: State) {
    self.initialState = initialState
  }

  func reduce(state: State, action: Action) async -> State {
    var newState = state
    switch action {
    case .onAppear:
      // TODO: onAppear때 만들지 말고 view의 Text눌렀을 때 만들어야 함
      newState.counterDetailInteractor = .init(
        initialState: .init(),
        delegate: self
      )
    case .didTapText:
      break
    }

    return newState
  }
}

extension RootReducer: CounterDetailDelegate {
  func didTapText() async -> String {
    switch await self.currentState.barnd {
    case .estelle:
      "estelle"
    case .gamzabada:
      "gamazabada"
    }
  }

  func disAppear() {
    // TODO: counterDetail back했을 때 해지 안되는 이슈 있음
//    self.currentState.counterDetailInteractor = nil
  }
}
