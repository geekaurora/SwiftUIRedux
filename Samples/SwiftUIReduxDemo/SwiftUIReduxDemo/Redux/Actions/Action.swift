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

/// Action with fetch feeds results.
struct FetchFeedsResultAction: ReduxActionProtocol {
  let feeds: [Feed]?
  let error: Error?
}

// MARK: - Comment

struct CommentLikeAction: ReduxActionProtocol {
  let comment: Comment
}

