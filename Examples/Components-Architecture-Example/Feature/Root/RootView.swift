//
//  RootView.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import SwiftUI

struct RootView: View {
  struct ViewState: ViewStatable {
    typealias R = RootReducer

    var number: String

    init(state: R.State) {
      self.number = "\(state.number)"
    }
  }
#if canImport(Observation)
  let interactor: InteractorOf<RootReducer, ViewState>
  #else
  @ObservedObject
  var interactor: InteractorOf<RootReducer, ViewState>
#endif
  init(interactor: InteractorOf<RootReducer, ViewState>) {
    self.interactor = interactor
  }

  var body: some View {
    HStack {
      Button {
        self.interactor.send(.didTapMinus)
      } label: {
        Text("-")
      }

      Text("\(self.interactor.viewState.number)")

      Button {
        self.interactor.send(.didTapPlus)
      } label: {
        Text("+")
      }
    }
  }
}
