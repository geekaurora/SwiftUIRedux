import Foundation
import CZUtils

public class Notification: Identifiable, Codable, CustomStringConvertible {
  static var mocks = (0..<10).map {
    Notification(title: "Notification\($0)", feed: Feed(feedId: $0, title: "feed\($0)"))
  }

  public var id = UUID()
  public let title: String
  public let feed: Feed
  
  public init(title: String, feed: Feed) {
    self.title = title
    self.feed = feed
  }
}
