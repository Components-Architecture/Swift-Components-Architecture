//
//  InteractorOf.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

// MARK: - Concept
/**
 View가 무슨 짓을 할 때 마다(send를 할 때 마다) Reducer의 명세대로 수행 후 View를 업데이트 한다.
 즉, Reducer는 직접적으로 State를 변경하거나 하지 않고, 오직 Interactor에서만 수행한다.
 이러한 컨셉이라면 Delegate는 Interactor를 들고 있는 객체에서 받는게 맞다. 수행의 주체는 Reducer가 아니라 Interactor이기 때문.
 Interactor가 모든 상황을 인지하고 Reducer에게 이럴 경우 어떻게 해? 라고 물어보면 Reducer가 답변을 주고 Interactor가 View에게 명령하는 형태이다.
 단어 그대로 Interactor는 View와 Reducer사이의 중개 열할을 해주는 셈이다.
**/

@MainActor
public final class InteractorOf<R: Reducer, V: Sendable>: ObservableObject, Sendable {
  private let reducer: R
  private var state: R.State
  
  @Published
  public var viewState: V
  
  public init(reducer: R) where V: ViewStatable, V.R == R {
    print("\(Self.self) init")
    self.reducer = reducer
    self.state = reducer.initialState

    self.viewState = V(state: reducer.initialState)
  }

  public init(reducer: R) where V == R.State {
    print("\(Self.self) init")
    self.reducer = reducer
    self.state = reducer.initialState
    self.viewState = reducer.initialState
  }
  
  deinit {
    print("\(Self.self) deinit state: ", self.state)
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
