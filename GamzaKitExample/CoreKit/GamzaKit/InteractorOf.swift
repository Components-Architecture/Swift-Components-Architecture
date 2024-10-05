//
//  InteractorOf.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

public actor InteractorOf<R: Reducer, V: Sendable> {
  private var reducer: R
  private var state: R.State
  
  @MainActor
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
  
  @MainActor
  public func send(_ action: R.Action) where V: ViewStatable, V.R == R {
    Task { [weak self] in
      guard let self else { return }
      let newState = await self.reducer.reduce(state: self.state, action: action)
      await self.updateState(newState)
      // @@ viewState업데이트할 때 마다 새로 생성중임. viewState는 actor/class일수도 있고, struct/enum(?)일 수도 있다.
      self.viewState = V(state: newState)
    }
  }
  
  @MainActor
  public func send(_ action: R.Action) where V == R.State {
    Task { [weak self] in
      guard let self else { return }
      let newState = await self.reducer.reduce(state: self.state, action: action)
      await self.updateState(newState)
      // @@ viewState업데이트할 때 마다 새로 생성중임. viewState는 actor/class일수도 있고, struct/enum(?)일 수도 있다.
      self.viewState = await self.state
    }
  }
  
  private func updateState(_ state: R.State) {
    self.state = state
  }
}
