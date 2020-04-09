import SwiftUIRedux
import CZUtils

public struct Comment: Identifiable, Codable, Equatable, CustomStringConvertible {  
  public var id = UUID()
  public var commentId: Int
  public let title: String
  public var isLiked: Bool {
    didSet { id = UUID() }
  }
  
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

extension Comment: ReduxStateProtocol {
  @discardableResult
  public func reduce(action: ReduxActionProtocol) -> Self {
    var newComment = self
    
    switch action {
    case let action as CommentLikeAction:
      // Update corresponding comment `isLiked`, and then reload UI by set `self.comments`.
      //if commentId == action.comment.commentId {
      if commentId == action.comment.commentId {
        newComment.isLiked = !action.comment.isLiked
      }
    default:
      return self
    }
    return newComment
  }
}
