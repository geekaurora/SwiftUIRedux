//
//  RegExHelper.swift
//
//  Created by Cheng Zhang on 2/18/20.
//  Copyright © 2020 Cheng Zhang. All rights reserved.
//

import Foundation

public class RegExHelper {
  
  /// Extract  variable with RegEx group match name. e.g.  "<h1>(?<var>.*)</h1>" pattern.
  /// - Note: Group name in `pattern` should be 'var'.
  public static func extractVariable(_ string: String,
                                     pattern: String,
                                     options: NSRegularExpression.Options = .caseInsensitive,
                                     groupName: String = "var") -> String? {
    guard let regex = (try? NSRegularExpression(pattern: pattern, options: options)).assertIfNil,
      let match = regex.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count)),
      let matchedRange = Range(match.range(withName: groupName), in: string) else {
        return nil
    }
    return String(string[matchedRange])
  }
  
  /// Extract  variables with RegEx group match name. e.g.  "<h1>(?<var>.*)</h1>" pattern.
  /// - Note: Group name in `pattern` should be 'var'.
  public static func extractVariables(_ string: String,
                                     pattern: String,
                                     options: NSRegularExpression.Options = .caseInsensitive,
                                     groupName: String = "var") -> [String] {
    guard let regex = (try? NSRegularExpression(pattern: pattern, options: options)).assertIfNil else {
        return []
    }
    let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
    let variables: [String] = matches.compactMap { match in
      guard let range = Range(match.range(withName: groupName), in: string) else {
        return nil
      }
      return String(string[range])
    }
    return variables
  }
}
