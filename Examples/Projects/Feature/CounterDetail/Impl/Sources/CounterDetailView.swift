//
//  CounterDetailView.swift
//  CounterDetailImpl
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import SwiftUI

public struct CounterDetailView: View {
    public struct ViewState: ViewStatable {
        public typealias R = CounterDetailReducer

        public init(state _: R.State) {}
    }

    @ObservedObject
    var interactor: InteractorOf<CounterDetailReducer, ViewState>
    public init(interactor: InteractorOf<CounterDetailReducer, ViewState>) {
        self.interactor = interactor
    }

    public var body: some View {
        Text("Hello, World!")
    }
}
