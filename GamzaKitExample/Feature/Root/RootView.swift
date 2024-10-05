//
//  RootView.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/3/24.
//

import SwiftUI

struct RootView: View {
  struct ViewState: ViewStatable {
    typealias R = RootReducer
    
    var number: String
    
    init(state: R.State) {
      self.number = "\(state.number)"
    }
  }
  
  let interactor: InteractorOf<RootReducer, RootReducer.State>
  
  init(interactor: InteractorOf<RootReducer, RootReducer.State>) {
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
