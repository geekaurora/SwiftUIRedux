import Foundation
import CZUtils

public class Feed: Identifiable, Codable, CustomStringConvertible {
  static let mocks = (0..<5).map { Feed(Id: $0, title: "Feed\($0)") }
  
  public var id = UUID()
  public var Id: Int
  public let title: String
  public var isLiked: Bool {
     didSet { id = UUID() }
  }
  
  public init(Id: Int, title: String, isLiked: Bool = false) {
    self.Id = Id
    self.title = title
    self.isLiked = isLiked
  }
  
//  public func hash(into hasher: inout Hasher) {
//    hasher.combine(id)
//    hasher.combine(title)
//    hasher.combine(isLiked)
//  }
//
//  public static func == (lhs: Feed, rhs: Feed) -> Bool {
//    return lhs.id == rhs.id &&
//      lhs.title == rhs.title &&
//      lhs.isLiked == rhs.isLiked
//  }
//
}
