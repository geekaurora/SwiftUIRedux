import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  public override func reduce(action: DispatcherActionProtocol) {
    switch action {
    case let action as FeedLikeAction:
      // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
      self.feeds = feeds.map { feed in
        if feed.Id == action.feed.Id {
          feed.isLiked = !feed.isLiked
        }
        return feed
      }
    default:
      break
    }
  }
}
