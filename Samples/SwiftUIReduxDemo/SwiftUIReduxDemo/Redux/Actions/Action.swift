import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

// MARK: - Feed

struct FeedLikeAction: ReduxActionProtocol {
  let feed: Feed
}

struct FeedAddCommentAction: ReduxActionProtocol {
  let feed: Feed
}

// MARK: - Comment

struct CommentLikeAction: ReduxActionProtocol {
  let comment: Comment
}

