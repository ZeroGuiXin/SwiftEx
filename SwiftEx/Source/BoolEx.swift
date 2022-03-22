//
//  BoolEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/22.
//

import Foundation

extension Bool {

  mutating func toggle() -> Bool {
    self = !self
    return self
  }
}
