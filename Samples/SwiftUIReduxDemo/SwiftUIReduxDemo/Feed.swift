import Foundation
import CZUtils

public class Feed: Codable, CustomStringConvertible, Hashable {
  static let mocks = (0..<1).map { Feed(id: $0, title: "Feed\($0)") }
  
  public var id: Int
  public let title: String
  public var isLiked: Bool
  
  public init(id: Int, title: String, isLiked: Bool = false) {
    self.id = id
    self.title = title
    self.isLiked = isLiked
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(title)
    hasher.combine(isLiked)
  }
  
  public static func == (lhs: Feed, rhs: Feed) -> Bool {
    return lhs.id == rhs.id &&
      lhs.title == rhs.title &&
      lhs.isLiked == rhs.isLiked
  }
  
}
