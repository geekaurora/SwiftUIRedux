//
//  Array+Extensoin.swift
//  CZUtils
//
//  Created by Cheng Zhang on 1/26/17.
//  Copyright © 2017 Cheng Zhang. All rights reserved.
//

import Foundation

public extension Array {
  /**
   Returns element at specified `safe` index if exists, otherwise nil
   */
  subscript (safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }

  /**
   Pretty formatted description string
   */
  var prettyDescription: String {
    return Pretty.describing(self)
  }

  /**
   Returns the first item that matches type `T` if exists, nil otherwise.
   */
  func firstTyped<T>(_ matchBlock: (Element) -> T?) -> T? {
    for item in self where matchBlock(item) != nil {
      return matchBlock(item)
    }
    return nil
  }

}

public extension Array where Element: NSCopying {
  func copy(with zone: NSZone? = nil) -> Any {
    return compactMap{ $0.copy() }
  }
}
