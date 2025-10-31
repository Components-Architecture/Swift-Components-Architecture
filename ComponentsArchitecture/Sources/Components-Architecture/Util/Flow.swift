//
//  File.swift
//  Swift-Components-Architecture
//
//  Created by wimes on 10/31/25.
//

import Foundation
@preconcurrency import Combine

public struct Flow<Element: Sendable>: Sendable, AsyncSequence {
  public typealias AsyncIterator = AsyncStream<Element>.Iterator
  public typealias Element = Element
  
  private let stream: AsyncStream<Element>
  
  public init(_ build: @escaping (
    @Sendable @escaping (Element) -> Void,
    @Sendable @escaping () -> Void) -> Void
  ) {
    self.stream = AsyncStream { continuation in
      build(
        { continuation.yield($0) },
        { continuation.finish() }
      )
    }
  }
  
  public init(
    _ build: @escaping (AsyncStream<Element>.Continuation) -> AnyCancellable?
  ) {
    self.stream = AsyncStream { continuation in
      let cancellable = build(continuation)
      continuation.onTermination = { @Sendable _ in
        cancellable?.cancel()
      }
    }
  }
  
  public func makeAsyncIterator() -> AsyncStream<Element>.Iterator {
    self.stream.makeAsyncIterator()
  }
}

public extension Flow {
  static var none: Self { Self { _, finish in finish() } }
  
  static func publisher<P: Publisher>(_ publisher: P) -> Self where P.Output == Self.Element, P.Failure == Never {
    Self { continuation in
      publisher.sink(
        receiveCompletion: { _ in
          continuation.finish()
        },
        receiveValue: { value in
          continuation.yield(value)
        }
      )
    }
  }
  
  static func just(_ element: Element) -> Self {
    Self { yield, finish in
      yield(element)
      finish()
    }
  }
  
  static func from(optional: Element?) -> Self {
    optional.map(self.just) ?? .none
  }
  
  static func task(_ work: @Sendable @escaping () async -> Element?) -> Self {
    Self { yield, finish in
      Task {
        if let v = await work() { yield(v) }
        finish()
      }
    }
  }
  
  static func merge(_ effects: Flow...) -> Flow {
    Self { yield, finish in
      Task {
        await withTaskGroup(of: Void.self) { group in
          for e in effects {
            group.addTask {
              for await v in e {
                yield(v)
              }
            }
          }
          await group.waitForAll()
        }
        finish()
      }
    }
  }
  
  static func merge<S: Sequence & Sendable>(_ effects: S) -> Flow where S.Element == Flow {
    return Self { yield, finish in
      Task {
        await withTaskGroup(of: Void.self) { group in
          for e in effects {
            group.addTask {
              for await v in e {
                yield(v)
              }
            }
          }
          await group.waitForAll()
        }
        finish()
      }
    }
  }
  
  static func concatenate(_ effects: Flow...) -> Flow {
    Self { yield, finish in
      Task {
        for e in effects {
          for await v in e {
            yield(v)
          }
        }
        finish()
      }
    }
  }
  
  static func concatenate<S: Sequence & Sendable>(_ effects: S) -> Flow where S.Element == Flow {
    Self { yield, finish in
      Task {
        for e in effects {
          for await v in e {
            yield(v)
          }
        }
        finish()
      }
    }
  }
}
