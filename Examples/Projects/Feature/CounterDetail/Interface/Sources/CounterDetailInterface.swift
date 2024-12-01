//
//  CounterDetailInterface.swift
//  CounterDetailInterface
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import SwiftUI

public protocol CounterDetailDelegate: AnyObject, Sendable {
  func didTapText() async -> String
}
