//
//  CounterDetailReducer.swift
//  CounterDetailImpl
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import CounterDetailInterface
import Foundation

public actor CounterDetailReducer: Reducer {
  public struct State: Sendable {
    var text: String
    
    public init(text: String = "Hello World!") {
      self.text = text
    }
  }

  public enum Action: Sendable {
    case onAppear
    case didTapText((@Sendable () async -> String?)?)
  }

  public let initialState: State

  public init(initialState: State) {
    self.initialState = initialState
  }

  public func reduce(state: State, action: Action) async -> State {
    var newState = state

    switch action {
    case .onAppear:
      print("\(Self.self) onAppear")
    case .didTapText(let function):
      guard let newText = await function?() else { return newState }
      newState.text = newText
    }

    return newState
  }
}
