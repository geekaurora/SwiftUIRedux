import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

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
      self.feeds = oldFeeds.map { feed in
        //feed.id = UUID()
        if feed.id == action.feed.id {
          feed.isLiked = !feed.isLiked
        }
        return feed
      }
      
//
//      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//        self.feeds = oldFeeds.map { feed in
//          feed.id = UUID()
//                      if feed.id == action.feed.id {
//                        feed.isLiked = !feed.isLiked
//                      }
//          feed.isLiked = true
//          return feed
//        }
//      }
    default:
      break
    }
  }
  
}

struct FeedListView: View {
  @ObservedObject
  var state = FeedListState()
  
  var body: some View {
    print("feeds: \(state.feeds)")
    return VStack {
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
