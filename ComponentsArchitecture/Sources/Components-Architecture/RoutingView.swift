//
//  File.swift
//  Swift-Components-Architecture
//
//  Created by Gihyun on 11/24/24.
//

import SwiftUI

public struct RoutingView<Content: View>: View {
  private let content: Content
  public init(content: Content) {
    self.content = content
  }
  
  public var body: some View {
    self.content
  }
}
