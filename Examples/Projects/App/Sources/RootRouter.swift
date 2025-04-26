//
//  RootRouter.swift
//  ComponentsArchitecture-Example
//
//  Created by wimes on 3/16/25.
//  Copyright © 2025 ComponentsArchitecture. All rights reserved.
//

import Foundation
import CounterDetailImpl
import CounterImpl
import ComponentsArchitecture

final class RootRouter: Routable {
  enum Route: Hashable {
    case counter(CounterReducer?)
    case counterDetail(CounterDetailReducer?)
  }
  
  @Published var paths: [Route] = []
  
  init() { }
}
