import SwiftUI
import SwiftUIRedux
import CZUtils

class FeedListState: NSObject, ObservableObject, SubscriberProtocol {
  @Published var feeds: [Feed] = Feed.mocks
  
  public override init() {
    super.init()
    
    // Subscribe to root Dispatcher.
    RootStore.shared.addSubscriber(self)
  }
  
  public func reduce(action: ActionProtocol) {
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
