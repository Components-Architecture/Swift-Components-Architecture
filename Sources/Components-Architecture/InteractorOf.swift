//
//  InteractorOf.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

#if canImport(Observation)
import Observation

@available(iOS 17.0, *)
@Observable @MainActor
public final class InteractorOf<R: Reducer, V: Sendable & Equatable>: Sendable {
  @ObservationIgnored
  private var reducer: R
  @ObservationIgnored
  private var state: R.State

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
      self.viewState = V(state: newState)
    }
  }

  public func send(_ action: R.Action) where V == R.State {
    Task { [weak self] in
      guard let self else { return }
      let newState = await self.reducer.reduce(state: self.state, action: action)
      self.state = newState
      self.viewState = self.state
    }
  }
}
#else
@MainActor
public final class InteractorOf<R: Reducer, V: Sendable, Equatable>: ObservableObject, Sendable {
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
      print("@@ isMainTrhead: ", Thread.isMainThread)
      let newState = await self.reducer.reduce(state: self.state, action: action)
      self.state = newState
      self.viewState = V(state: newState)
    }
  }
  
  public func send(_ action: R.Action) where V == R.State {
    Task { [weak self] in
      guard let self else { return }
      print("@@ isMainTrhead: ", Thread.isMainThread)
      let newState = await self.reducer.reduce(state: self.state, action: action)
      self.state = newState
      self.viewState = self.state
    }
  }
}
#endif
