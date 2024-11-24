//
//  RootReducer.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import Foundation

protocol Middlewarable {}

actor RootReducer: Reducer {
    struct State {
        // @@ 하위 state를 받을 이유가 있나? -> 모듈을 분리하려면 router를 이용하는게 맞을거 같다.
    }

    enum Action {
        case didTapText
    }

    let initialState: State

    init(initialState: State) {
        self.initialState = initialState
    }

    func reduce(state: State, action: Action) async -> State {
        switch action {
        case .didTapText:
            break
        }

        return state
    }
}
