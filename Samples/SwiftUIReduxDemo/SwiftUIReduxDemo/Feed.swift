import Foundation
import CZUtils

public class FeedMock: Identifiable, Codable, CustomStringConvertible {
  static func generateFeeds() -> [Feed] {
    return (0..<5).map { Feed(Id: $0, title: "Feed\($0)") }
  }
}
  
public class Feed: Identifiable, Codable, CustomStringConvertible {
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
}
