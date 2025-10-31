//
//  RootView.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterListInterface
import CounterListImpl
import SwiftUI

struct RootView: View {
  @StateObject
  var interactor: RootInteractor
  
  init(interactor: RootInteractor) {
    self._interactor = .init(wrappedValue: interactor)
  }
  
  var body: some View {
    NavigationStack(path: self.$interactor.state.paths) {
      Button {
        self.interactor.send(.didTapRootView)
      } label: {
        Text("I'm Root View")
      }
      .navigationDestination(for: RootInteractor.State.Path.self) { path in
        switch path {
        case .counterList(let interactor):
          CounterListView(interactor: interactor)
        }
      }
    }
    .onAppear {
      self.interactor.send(.onAppear)
    }
  }
}
