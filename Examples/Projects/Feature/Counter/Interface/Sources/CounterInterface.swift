//
//  CounterInterface.swift
//  CounterInterface
//
//  Created by Gihyun on 11/24/24.
//  Copyright © 2024 ComponentsArchitecture. All rights reserved.
//

import ComponentsArchitecture
import SwiftUI

public protocol CounterRoutable {
    associatedtype _CounterDetail: View

    func routeCounterDetail() -> RoutingView<_CounterDetail>
}
