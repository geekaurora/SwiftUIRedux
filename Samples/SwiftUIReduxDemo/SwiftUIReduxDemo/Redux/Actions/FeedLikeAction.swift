import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedLikeAction: ReduxActionProtocol {
  let feed: Feed
}

func dispatchLikeFeedAction(feed: Feed) {
  // Deep copy to retain current state, so avoid duplicate mutations on the same model.
  let copy = feed.codableCopy()
  dispatch(action: FeedLikeAction(feed: copy))
} 

