import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedCell: View {
  let feed: Feed
  
  var body: some View {
    
    VStack {
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
            
      // Comment list
      CommentListView(comments: feed.comments)
      Spacer()
    }
  }
  
}
