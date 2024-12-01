//
//  InteractorOf.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

@MainActor
public final class InteractorOf<R: Reducer, V: Sendable>: ObservableObject, Sendable {
  private let reducer: R
  private var state: R.State
  
  @Published
  public var viewState: V

  public init(reducer: R) where V: ViewStatable, V.R == R {
    self.reducer = reducer
    self.state = reducer.initialState

    self.viewState = V(state: reducer.initialState)
  }

  public init(reducer: R) where V == R.State {
    self.reducer = reducer
    self.state = reducer.initialState
    self.viewState = reducer.initialState
  }
  
  public func send(_ action: R.Action) where V: ViewStatable, V.R == R {
    Task { [weak self] in
      guard let self else { return }
      let newState = await self.reducer.reduce(state: self.state, action: action)
      self.state = newState
      await StateStore.currentState.setValue(self.state, forKey: self.reducer.self)
      self.viewState = V(state: newState)
    }
  }
  
  public func send(_ action: R.Action) where V == R.State {
    Task { [weak self] in
      guard let self else { return }
      let newState = await self.reducer.reduce(state: self.state, action: action)
      self.state = newState
      await StateStore.currentState.setValue(self.state, forKey: self.reducer.self)
      self.viewState = self.state
    }
  }
}
