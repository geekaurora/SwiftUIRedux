import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedCell: View {
  let feed: Feed
  var body: some View {
    HStack {
      Text(feed.title)
        .modifier(ContentTextStyle())
      
      Spacer()
      Button(action: {
        print("tapped like.")
        dispatchLikeFeedAction(feed: self.feed)
      }) {
        Text(feed.isLiked ? "UnLike" : "Like")
      }
      .modifier(NormalButtonStyle())
    }
  }
}

struct FeedListView: View {
  @ObservedObject
  var state = FeedListState()
  
  var body: some View {
    return List {
      ForEach(state.feeds) { feed in
        NavigationLink(destination: FeedDetailsView(feed: feed)) {
          FeedCell(feed: feed)
        }
      }
    }
    
  }
}

struct FeedListView_Previews: PreviewProvider {
  static var previews: some View {
    FeedListView()
  }
}
