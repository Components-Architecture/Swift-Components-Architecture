//
//  Reducer.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

public protocol Reducer: AnyObject, Sendable {
  associatedtype State: Sendable
  associatedtype Action: Sendable

  var initialState: State { get }

  func reduce(state: State, action: Action) async -> State
}
