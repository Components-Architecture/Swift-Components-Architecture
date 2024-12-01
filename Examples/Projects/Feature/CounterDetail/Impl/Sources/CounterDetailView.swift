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

  @ObservedObject
  var interactor: InteractorOf<CounterDetailReducer, ViewState>
  public init(interactor: InteractorOf<CounterDetailReducer, ViewState>) {
    self.interactor = interactor
  }

  public var body: some View {
    Button {
      interactor.send(.didTapText)
    } label: {
      Text(interactor.viewState.text)
    }
  }
}
