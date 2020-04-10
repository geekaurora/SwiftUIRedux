//
//  Utils.swift
//  CZUtils
//
//  Created by Cheng Zhang on 2/19/18.
//  Copyright © 2018 Cheng Zhang. All rights reserved.
//

import Foundation

public class CZUtils {
    public static func dbgPrint(_ item: CustomStringConvertible) {
        #if DEBUG
            print(item)
        #endif
    }
}

public func dbgPrint(_ item: CustomStringConvertible) {
    dbgPrint(.`default`, item)
}

public func dbgPrint(_ type: DbgPrintType,
                     _ item: CustomStringConvertible) {
  CZUtils.dbgPrint(type.prefix + item.description)
}

public enum DbgPrintType {
  case `default`
  case warning
  case error
  
  var prefix: String {
    switch self {
    case .`default`: return ""
    case .warning: return "[Warning] "
    case .error: return "[Error] "
    }
  }
}
