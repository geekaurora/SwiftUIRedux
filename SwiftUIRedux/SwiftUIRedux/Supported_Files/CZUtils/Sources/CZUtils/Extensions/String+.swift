//
//  String+
//
//  Created by Cheng Zhang on 1/5/16.
//  Copyright © 2016 Cheng Zhang. All rights reserved.
//

import Foundation

public extension String {
  /**
   Search substrings that matches regex pattern

   - parameter regex: the regex pattern
   - parameter excludeRegEx: indicates whether returned substrings exclude regex pattern iteself

   - returns: all matched substrings
   */
  func search(regex: String, excludeRegEx: Bool = true) -> [String] {
    guard let regex = try? NSRegularExpression(pattern: regex, options: []) else {
      return []
    }
    let string = self as NSString
    let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, string.length))
    return results.compactMap { result in
      guard result.numberOfRanges > 0 else {
        return nil
      }
      let i = excludeRegEx ? (result.numberOfRanges - 1) : 0
      return result.range(at: i).location != NSNotFound ? string.substring(with: result.range(at: i)) : nil
    }
  }

  /**
   URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
   URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
   URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
   URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
   URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
   URLUserAllowedCharacterSet      "#%/:<>?@[\]^`

   http://stackoverflow.com/questions/24551816/swift-encode-url
   */
  func urlEncoded()-> String {
    guard firstIndex(of: "%") == nil else { return self }
    let mutableString = NSMutableString(string: self)
    let urlEncoded = mutableString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    return urlEncoded ?? ""
  }

  /// Returns alphanumeric string.
  var alphanumeric: String {
    let pattern = "[^A-Za-z0-9]+"
    let res = replacingOccurrences(
      of: pattern,
      with: "",
      options: [.regularExpression])
    return res
  }

  /// Returns Int value.
  var intValue: Int? {
    return Int(self)
  }

  /**
   Returns splitted Strings with input `separator`, `maxSplits`, `omittingEmptySubsequences`.
   */
  func splitToStrings(separator: Character,
                      maxSplits: Int = Int.max,
                      omittingEmptySubsequences: Bool = true) -> [String] {
    return split(
      separator: separator,
      maxSplits: maxSplits,
      omittingEmptySubsequences: omittingEmptySubsequences)
      .map { String($0) }
  }

}

public extension NSAttributedString {
  static func string(withHtml html: String) -> NSAttributedString? {
    let attributedString = try? NSAttributedString(
      data: html.data(using: .utf8)!,
      options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
      documentAttributes: nil)
    return attributedString
  }
}
