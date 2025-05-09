//
//  CounterInterface.swift
//  CounterInterface
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import SwiftUI

@MainActor
public protocol CounterDelegate: Sendable {
  func didTapNumber(_ number: Int) async
}
