//
//  CounterDetailView.swift
//  CounterDetailImpl
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import CounterDetailInterface
import SwiftUI

public struct CounterDetailView: View {
  public struct ViewState: ViewStatable {
    public typealias R = CounterDetailReducer

    let text: String

    public init(state: R.State) {
      self.text = state.text
    }
  }

  @StateObject
  var interactor: InteractorOf<CounterDetailReducer, ViewState>
  
  private let delegate: CounterDetailDelegate?
  
  public init(interactor: InteractorOf<CounterDetailReducer, ViewState>, delegate: CounterDetailDelegate?) {
    self._interactor = .init(wrappedValue: interactor)
    self.delegate = delegate
  }

  public var body: some View {
    VStack {
      Button {
        self.interactor.send(.didTapText { await self.delegate?.didTapText() })
      } label: {
        Text(self.interactor.viewState.text)
      }
      .onAppear {
        self.interactor.send(.onAppear)
      }
      
      Button {
        self.delegate?.didTapPop()
      } label: {
        Text("pop")
      }
      
      Button {
        self.delegate?.didTapPopToRoot()
      } label: {
        Text("popToRoot")
      }
    }
  }
}
