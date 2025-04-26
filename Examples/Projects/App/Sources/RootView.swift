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
  
  @ObservedObject
  var interactor: InteractorOf<RootReducer, ViewState>
  @ObservedObject
  var router: RootRouter
  
  init(interactor: InteractorOf<RootReducer, ViewState>, router: RootRouter) {
    self.interactor = interactor
    self.router = router
  }
  
  var body: some View {
    NavigationStack(path: self.$router.paths) {
      Button {
        self.router.push(
          route: .counter(.init(reducer: .init(initialState: .init(number: 0))))
        )
      } label: {
        Text("I'm Root View")
      }
      .navigationDestination(for: RootRouter.Route.self) { route in
        switch route {
        case .counter(let interactor):
          CounterView(interactor: interactor, delegate: self)
            .task {
              let num = interactor.state.number
              print("CounterReducer.num: ", num)
            }
        case .counterDetail(let interactor):
          CounterDetailView(interactor: interactor, delegate: self)
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
    self.router.push(route: .counterDetail(.init(reducer: .init(initialState: .init(text: "\(number)")))))
  }
}

extension RootView: CounterDetailDelegate {
  func didTapText() async -> String {
    return ""
  }
  
  func didTapPop() {
    self.router.pop()
  }
  
  func didTapPopToRoot() {
    self.router.popToRoot()
  }
}
