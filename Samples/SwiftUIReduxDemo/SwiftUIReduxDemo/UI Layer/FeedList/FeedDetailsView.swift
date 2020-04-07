import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedDetailsView: View {
  @ObservedObject var state: FeedDetailsState
  
  init(feed: Feed) {
    self.state = FeedDetailsState(feed: feed)
  }
  
  var body: some View {
    HStack {
      Text(state.feed.title)
        .modifier(ContentTextStyle())
      
      Spacer()
      
      Button(action: {
        print("tapped like.")
        dispatch(action: FeedLikeAction(feed: self.state.feed))
      }) {
        Text(state.feed.isLiked ? "UnLike" : "Like")
      }.modifier(NormalButtonStyle())
    }
  }
}
