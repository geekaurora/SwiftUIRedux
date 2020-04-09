import SwiftUIRedux
import CZUtils

public struct Feed: Identifiable, Codable, Equatable, CustomStringConvertible {
  static var mocks = (0..<10).map {
    Feed(feedId: $0, title: "feed\($0)")
  }
  
  public var id = UUID()
  public var feedId: Int
  public let title: String
  public var isLiked: Bool {
    didSet { id = UUID() }
  }
  
  public var comments: [Comment] = [] {
    didSet { id = UUID() }
  }
  
  public init(feedId: Int, title: String, isLiked: Bool = false) {
    self.feedId = feedId
    self.title = title
    self.isLiked = isLiked
    self.addComment()
  }
  
  public mutating func addComment() {
    let commentId = comments.count
    let comment = Comment(commentId: commentId, title: "comment\(commentId)")
    self.comments = comments + [comment]
  }
  
  // MARK: - Equatable
  
  public static func == (lhs: Feed, rhs: Feed) -> Bool {
    return lhs.isEqual(toCodable: rhs)
  }
}

extension Feed: ReduxStateProtocol {
  @discardableResult
  public func reduce(action: ReduxActionProtocol) -> Self {
    // Note: deep copy of `self`.
    var newFeed = self
    
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      //if feedId == action.feed.feedId {
      if feedId == action.feed.feedId {
        newFeed.isLiked = !action.feed.isLiked
      }
    case let action as FeedAddCommentAction:
      if feedId == action.feed.feedId {
        newFeed.addComment()
      }
    default:
      return self
    }
    return newFeed
  }
}
