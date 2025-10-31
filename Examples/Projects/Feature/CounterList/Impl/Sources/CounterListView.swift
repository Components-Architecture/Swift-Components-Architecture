//
//  CounterListView.swift
//  CounterListImpl
//
//  Created by wimes on 10/31/25.
//  Copyright © 2025 ComponentsArchitecture. All rights reserved.
//

import SwiftUI

public struct CounterListView: View {
  @StateObject
  var interactor: CounterListInteractor
  
  public init(interactor: CounterListInteractor) {
    self._interactor = .init(wrappedValue: interactor)
  }
  
  public var body: some View {
    Button {
      self.interactor.send(.didTapIncreaseOdd)
    } label: {
      Text("Increase")
    }
    
    List(self.interactor.state.items, id: \.self) { item in
      ItemView(interactor: item)
    }
    .onAppear {
      self.interactor.send(.onAppear)
    }
  }
}
