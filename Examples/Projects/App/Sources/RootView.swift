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

        let counterInteractor: InteractorOf<CounterReducer, CounterView.ViewState>

        init(state _: R.State) {
            counterInteractor = .init(
                reducer: CounterReducer(initialState: CounterReducer.State(number: 0))
            )
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
                CounterView(interactor: interactor.viewState.counterInteractor)
            } label: {
                Text("AReducer")
            }
        }
    }
}
