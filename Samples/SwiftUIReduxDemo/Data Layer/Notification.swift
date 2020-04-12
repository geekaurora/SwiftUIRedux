import SwiftUIKit
import SwiftUIRedux
import CZUtils

public struct Notification: ListDiffable, Codable, Equatable, CustomStringConvertible {
  static let mocks = (0..<10).map {
    Notification(title: "Notification\($0)", feed: Feed(feedId: $0, title: "feed\($0)"))
  }

  public var diffId = UUID()
  public let title: String
  public var feed: Feed {
    willSet {
      if feed != newValue {
        updateDiffId()
      }
    }
  }
  
  public init(title: String, feed: Feed) {
    self.title = title
    self.feed = feed
  }
  
  // MARK: - Equatable
  
  public static func == (lhs: Notification, rhs: Notification) -> Bool {
    lhs.isEqual(toCodable: rhs)
  }
}

// MARK: - ReduxStateProtocol

extension Notification: ReduxStateProtocol {
  @discardableResult
  public func reduce(action: ReduxActionProtocol) -> Self {
    // Note: deep copy of `self`.
    var newNotification = self
    newNotification.feed = feed.reduce(action: action)
    return newNotification
  }
}

