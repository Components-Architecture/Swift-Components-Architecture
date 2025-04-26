//
//  ViewStatable.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

@MainActor
public protocol ViewStatable: Sendable {
  associatedtype R where R: Reducer
  init(state: R.State)
}
