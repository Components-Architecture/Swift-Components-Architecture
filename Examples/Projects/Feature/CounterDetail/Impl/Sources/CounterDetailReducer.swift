//
//  CounterDetailReducer.swift
//  CounterDetailImpl
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import Foundation

public actor CounterDetailReducer: Reducer {
    public struct State: Sendable {}

    public enum Action: Sendable {}

    public let initialState: State

    public init(initialState: State) {
        self.initialState = initialState
    }

    public func reduce(state: State, action _: Action) async -> State {
        var newState = state

        return newState
    }
}
