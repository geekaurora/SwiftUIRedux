import SwiftUI
import SwiftUIRedux
import CZUtils

/// Convenience method to dispatch `action` to subscribers of `RootDispatcher.shared`.
public func dispatch(action: DispatcherActionProtocol) {
  RootDispatcher.shared.dispatch(action: action)
}

struct FeedLikeAction: DispatcherActionProtocol {
  let feed: Feed
}

struct FeedCell: View {
  let feed: Feed
  
  var body: some View {
    HStack {
      Text(feed.title)
      Spacer()
      Button(action: {
        print("tapped like.")
        dispatch(action: FeedLikeAction(feed: self.feed))
      }) {
        Text(feed.isLiked ? "UnLike" : "Like")
      }
    }
  }
}

class FeedListState: NSObject, ObservableObject, SubscriberProtocol {
  @Published var feeds: [Feed] = Feed.mocks
  
  public override init() {
    super.init()
    // Subscribe to the root dispatcher.
    RootDispatcher.shared.addSubscriber(self)
  }
  
  public func reduce(action: DispatcherActionProtocol) {
    switch action {
      case let action as FeedLikeAction:
        let oldFeeds = feeds
        self.feeds = []
        // Update corresponding feed `isLiked`, and then reload UI by set `self.feeds`.
//        CZMainQueueScheduler.async {
//          self.feeds = oldFeeds.map { feed in
//            if feed.id == action.feed.id {
//              feed.isLiked = !feed.isLiked
//            }
//            return feed
//          }
//        }
    default:
      break
    }
  }
  
}

struct FeedListView: View {
  @ObservedObject
  var state = FeedListState()
  
  var body: some View {    
    List {
      ForEach(state.feeds) { feed in
        FeedCell(feed: feed)
      }
    }
  }
}

struct FeedListView_Previews: PreviewProvider {
  static var previews: some View {
    FeedListView()
  }
}
