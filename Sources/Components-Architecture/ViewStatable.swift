//
//  ViewStatable.swift
//  GamzaKitExample
//
//  Created by Gihyun on 10/5/24.
//

import Foundation

// @@ -> 이럴거면 그냥 View를 protocol로 한번 감싸는건 어때?
public protocol ViewStatable: Sendable {
  associatedtype R where R: Reducer
  init(state: R.State)
}
