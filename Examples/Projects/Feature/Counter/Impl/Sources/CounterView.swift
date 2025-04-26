//
//  CounterView.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import CounterDetailInterface
import CounterInterface
import Foundation
import SwiftUI

public struct CounterView: View {
  public struct ViewState: ViewStatable {
    public typealias R = CounterReducer

    public var number: String {
      didSet {
        print("##")
      }
    }

    public init(state: R.State) {
      number = "\(state.number)"
    }
  }

  @StateObject
  var interactor: InteractorOf<CounterReducer, ViewState>
  private let delegate: CounterDelegate?

  public init(interactor: InteractorOf<CounterReducer, ViewState>, delegate: CounterDelegate?) {
    self._interactor = .init(wrappedValue: interactor)
    self.delegate = delegate
  }
  
  public var body: some View {
    let _ = Self._printChanges()
    VStack {
      HStack {
        Button {
          self.interactor.send(.didTapMinus)
        } label: {
          Text("-")
        }

        Button {
          self.interactor.send(.didTapNumber({ await self.delegate?.didTapNumber($0) }))
        } label: {
          Text("\(self.interactor.viewState.number)")
        }
        
        Button {
          self.interactor.send(.didTapPlus)
        } label: {
          Text("+")
        }
      }
    }
  }
}
