//
//  RootView.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterDetailImpl
import CounterImpl
import SwiftUI

struct RootView: View {
  struct ViewState: ViewStatable {
    typealias R = RootReducer

    let counterDetail: CounterDetailReducer?

    init(state: R.State) {
      self.counterDetail = state.counterDetailInteractor
    }
  }

  @ObservedObject
  var interactor: InteractorOf<RootReducer, ViewState>

  init(interactor: InteractorOf<RootReducer, ViewState>) {
    self.interactor = interactor
  }

  var body: some View {
    NavigationView {
      NavigationLink {
        if let reduer = interactor.viewState.counterDetail {
          CounterDetailView(interactor: .init(reducer: reduer))
        }
      } label: {
        Text("CounterDetail")
      }
    }
    .onAppear {
      interactor.send(.onAppear)
    }
  }
}
