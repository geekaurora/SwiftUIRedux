import Foundation
import CZUtils

public class Notification: Identifiable, Codable, CustomStringConvertible {
  static var mocks = (0..<5).map {
    Notification(Id: $0, title: "Notification\($0)", feed: Feed(Id: $0, title: "Feed\($0)"))
  }

  public var id = UUID()
  public var Id: Int
  public let title: String
  public let feed: Feed
  
  public init(Id: Int, title: String, feed: Feed) {
    self.Id = Id
    self.title = title
    self.feed = feed
  }
}
