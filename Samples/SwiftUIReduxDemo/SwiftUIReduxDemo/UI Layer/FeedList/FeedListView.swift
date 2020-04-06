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

struct FeedListView: View {
  @ObservedObject
  var state = FeedListState()
  
  var body: some View {
    // print("feeds: \(state.feeds)")
    return List {
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