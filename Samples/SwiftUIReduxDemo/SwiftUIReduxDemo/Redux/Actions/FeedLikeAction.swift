import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedLikeAction: ReduxActionProtocol {
  let feed: Feed
}

func dispatchLikeFeedAction(feed: Feed) {
  // Deep copy to retain current state, so avoid duplicate mutations on the same model.
  //let copy = feed.codableCopy()
  //dispatch(action: FeedLikeAction(feed: copy))

  // No need deep copy to retain current state,
  // as Feed/Notification are now stuct, will create deep copy automatically,
  // so avoid duplicate mutations on the same model.
  dispatch(action: FeedLikeAction(feed: feed))
}

struct CommentLikeAction: ReduxActionProtocol {
  let comment: Comment
}

func dispatchLikeCommentAction(comment: Comment) {
  dispatch(action: CommentLikeAction(comment: comment))
}

