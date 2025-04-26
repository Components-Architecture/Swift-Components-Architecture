//
//  CounterDetailInterface.swift
//  CounterDetailInterface
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import SwiftUI

@MainActor
public protocol CounterDetailDelegate: Sendable {
  func didTapText() async -> String
  func didTapPop()
  func didTapPopToRoot()
}
