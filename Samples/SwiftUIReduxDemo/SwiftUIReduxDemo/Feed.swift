import Foundation
import CZUtils

public class Feed: Identifiable, Codable, CustomStringConvertible {
  static let mocks = (0..<10).map { Feed(title: "Feed\($0)") }
  
  public let id = UUID()
  public let title: String
  public var isLiked: Bool
  
  public init(title: String, isLiked: Bool = false) {
    self.title = title
    self.isLiked = isLiked
  }
}
