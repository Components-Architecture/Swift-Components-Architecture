//
//  GamzaKitExampleApp.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/3/24.
//

import SwiftUI

@main
struct GamzaKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
          let reducer = RootReducer(initialState: RootReducer.State(number: 0))
          RootView(interactor: InteractorOf<RootReducer, RootReducer.State>(reducer: reducer))
        }
    }
}
