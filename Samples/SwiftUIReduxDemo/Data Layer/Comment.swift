import Foundation
import SwiftUIKit
import SwiftUIRedux
import CZUtils

public struct Comment: ListDiffable, Codable, Equatable, CustomStringConvertible {
  public var commentId: Int
  public let title: String
  public var isLiked: Bool

  public init(commentId: Int, title: String, isLiked: Bool = false) {
    self.commentId = commentId
    self.title = title
    self.isLiked = isLiked
  }
  
  // MARK: - Equatable
  
  public static func == (lhs: Comment, rhs: Comment) -> Bool {
    return lhs.isEqual(toCodable: rhs)
  }
}

// MARK: - ReduxStateProtocol

extension Comment: ReduxStateProtocol {
  @discardableResult
  public func reduce(action: ReduxActionProtocol) -> Self {
    // Note: deep copy of `self`.
    var newComment = self
    
    switch action {
    case let action as CommentLikeAction:
      if commentId == action.comment.commentId {
        newComment.isLiked = !action.comment.isLiked
      }
    default:
      return self
    }
    return newComment
  }
}
