//
//  MapTable.swift
//  Swift-Components-Architecture
//
//  Created by Gihyun on 12/1/24.
//

import Foundation

final actor MapTable<Key, Value> where Key: AnyObject {
  private var dictionary: [HashObject<Key>: Value] = [:]
  
  public func setValue(_ value: Value, forKey key: Key) {
    let hashObject = HashObject(key)
    self.dictionary[hashObject] = value
  }
  
  public func getValue(forKey key: Key) -> Value? {
    let hashObject = HashObject(key)
    return self.dictionary[hashObject]
  }
}

fileprivate final class HashObject<T>: Hashable where T: AnyObject {
  private let objectHashValue: Int
  weak var object: T?

  init(_ object: T) {
    self.objectHashValue = ObjectIdentifier(object).hashValue
    self.object = object
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.objectHashValue)
  }

  static func == (lhs: HashObject<T>, rhs: HashObject<T>) -> Bool {
    return lhs.objectHashValue == rhs.objectHashValue
  }
}
