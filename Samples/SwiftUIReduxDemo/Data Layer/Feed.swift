import CZUtils
import SwiftUIKit
import SwiftUIRedux

public struct Feed: ListDiffable, Codable, Equatable, CustomStringConvertible {
  static var mocks = (0..<10).map {
    Feed(feedId: $0, title: "feed\($0)")
  }
    
  public var diffId = UUID()
  public let feedId: Int
  public let title: String
  public var isLiked: Bool { didSet { updateDiffId() } }
  
  public var comments: [Comment] = [] {
    didSet { updateDiffId() }
  }
  
  public init(feedId: Int, title: String, isLiked: Bool = false) {
    self.feedId = feedId
    self.title = title
    self.isLiked = isLiked
    self.addComment()
  }
    
  public mutating func addComment() {
    let commentId = feedId * 1000 + comments.count
    let comment = Comment(commentId: commentId, title: "comment\(comments.count)")
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
    newFeed.comments = comments.map { $0.reduce(action: action) }
    
    switch action {
    case let action as FeedLikeAction:
      // Updates the corresponding `isLiked` of feed.
      if feedId == action.feed.feedId {
        newFeed.isLiked = !action.feed.isLiked
      }
    case let action as FeedAddCommentAction:
      if feedId == action.feed.feedId {
        newFeed.addComment()
      }
    default:
      break
    }
    return newFeed
  }
}
