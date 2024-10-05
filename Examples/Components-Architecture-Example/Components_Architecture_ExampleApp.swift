//
//  Components_Architecture_ExampleApp.swift
//  Components-Architecture-Example
//
//  Created by Milkyo on 10/5/24.
//

import ComponentsArchitecture
import SwiftUI

@main
struct Components_Architecture_ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      let reducer = RootReducer(initialState: RootReducer.State(number: 0))
      RootView(interactor: InteractorOf<RootReducer, RootReducer.State>(reducer: reducer))
    }
  }
}
