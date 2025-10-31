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
      let interactor = RootInteractor(initialState: .init())
      RootView(interactor: interactor)
    }
  }
}
