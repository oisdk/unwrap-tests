//
//  UnwrapTests.swift
//  UnwrapTests
//
//  Created by Donnacha Oisín Kidney on 17/09/2015.
//  Copyright © 2015 Donnacha Oisín Kidney. All rights reserved.
//

import XCTest

protocol Unwrapable {
  typealias Unwrapped
  func unwrap() -> Unwrapped?
}

extension Optional: Unwrapable {
  func unwrap() -> Wrapped? {
    return self
  }
}

extension SequenceType where Generator.Element: Unwrapable {
  func unwrap() -> Array<Generator.Element.Unwrapped> {
    return self.map { $0.unwrap() }.filter({ $0 != nil }).map({ $0! })
  }
}

let ar: [Int?] = (0...10000000).map { n in n % 13 == 0 ? nil : n }

class UnwrapTests: XCTestCase {
  
  func testUnwrap() {
    self.measureBlock {
      let x = ar.unwrap()
    }
  }
  func testFlatMap() {
    self.measureBlock {
      let x = ar.flatMap{$0}
    }
  }
}
