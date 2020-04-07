import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      self.feeds = feeds.map { feed in
        if feed.feedId == action.feed.feedId {
          feed.isLiked = !feed.isLiked
        }
        return feed
      }
    default:
      break
    }
  }
  
}
