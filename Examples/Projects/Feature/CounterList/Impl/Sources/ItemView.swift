//
//  File.swift
//  
//
//  Created by wimes on 10/31/25.
//

import SwiftUI

struct ItemView: View {
  @StateObject
  var interactor: ItemInteractor
  
  init(interactor: ItemInteractor) {
    self._interactor = .init(wrappedValue: interactor)
  }
  
  var body: some View {
    Button {
      self.interactor.send(.didTapButton)
    } label: {
      ZStack {
        let color: UIColor = switch self.interactor.state.backgroundColor {
        case .red:
            .red
        case .white:
            .white
        }
        
        Color(color)
        Text("\(self.interactor.state.count)")
      }
    }
  }
}
