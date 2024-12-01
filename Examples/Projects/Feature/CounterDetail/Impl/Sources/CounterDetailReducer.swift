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
    var text: String = "Hello World!"
    public init() {}
  }

  public enum Action: Sendable {
    case didTapText
  }

  public let initialState: State
  private weak var delegate: CounterDetailDelegate?

  public init(initialState: State, delegate: CounterDetailDelegate?) {
    self.initialState = initialState
    self.delegate = delegate
  }

  public func reduce(state: State, action: Action) async -> State {
    var newState = state

    switch action {
    case .didTapText:
      guard let newText = await self.delegate?.didTapText() else { return newState }
      newState.text = newText
    }

    return newState
  }
}
