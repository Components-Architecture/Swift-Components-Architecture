//
//  RootView.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterDetailInterface
import CounterDetailImpl
import CounterInterface
import CounterImpl
import SwiftUI

struct RootView: View {
  struct ViewState: ViewStatable {
    typealias R = RootReducer
    
    init(state: R.State) { }
  }
  
  @StateObject
  var interactor: InteractorOf<RootReducer, ViewState>
  @StateObject
  var router: RootRouter
  
  init(interactor: InteractorOf<RootReducer, ViewState>, router: RootRouter) {
    self._interactor = .init(wrappedValue: interactor)
    self._router = .init(wrappedValue: router)
  }
  
  var body: some View {
    NavigationStack(path: self.$router.paths) {
      Button {
        self.router.push(route: .counter(.init(initialState: .init(number: 0))))
      } label: {
        Text("I'm Root View")
      }
      .navigationDestination(for: RootRouter.Route.self) { route in
        switch route {
        case .counter(let reducer):
          if let reducer {
            CounterView(interactor: .init(reducer: reducer), delegate: self)
              .task {
                let num = await reducer.currentState.number
                print("CounterReducer.num: ", num)
              }
          }
        case .counterDetail(let reducer):
          if let reducer {
            CounterDetailView(interactor: .init(reducer: reducer), delegate: self)
          }
        }
      }
    }
    .onAppear {
      self.interactor.send(.onAppear)
    }
  }
}

extension RootView: CounterDelegate {
  func didTapNumber(_ number: Int) async {
    self.router.push(route: .counterDetail(.init(initialState: .init(text: "\(number)"))))
  }
}

extension RootView: CounterDetailDelegate {
  func didTapText() async -> String {
    return ""
  }
}
