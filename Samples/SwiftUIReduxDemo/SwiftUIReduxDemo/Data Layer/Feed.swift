import SwiftUIRedux
import CZUtils

public class Feed: Identifiable, Codable, Equatable, CustomStringConvertible {
  
  static var mocks = (0..<10).map { Feed(feedId: $0, title: "feed\($0)") }
  
  public var id = UUID()
  public var feedId: Int
  public let title: String
  public var isLiked: Bool {
    didSet { id = UUID() }
  }
  
  public init(feedId: Int, title: String, isLiked: Bool = false) {
    self.feedId = feedId
    self.title = title
    self.isLiked = isLiked
  }
  
  // MARK: - Equatable
  
  public static func == (lhs: Feed, rhs: Feed) -> Bool {
    return lhs.isEqual(toCodable: rhs)
  }
  
}

extension Feed: ReduxStateProtocol {
  
  @discardableResult
  public func reduce(action: ReduxActionProtocol) -> Self {
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      if feedId == action.feed.feedId {
        isLiked = !isLiked
      }
    default:
      break
    }
    return self
  }
  
}
