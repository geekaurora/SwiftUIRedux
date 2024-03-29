import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct FeedCell: View {
  let feed: Feed
  
  var body: some View {
    // dbgPrintWithFunc(self, "Load \(type(of:self)) - diffId = \(feed.diffId)")
    
    return VStack(alignment: .leading) {
      HStack {
        // Title text
        Text(feed.title)
          .modifier(ContentTextStyle())
        Spacer()
        
        // Comment button
        Button(action: {
          print("tapped AddComment.")
          dispatch(action: FeedAddCommentAction(feed: self.feed))
        }) {
          Text("Comment")
        }.modifier(NormalButtonStyle())
        
        // Like button
        Button(action: {
          print("tapped like.")
          dispatch(action: FeedLikeAction(feed: self.feed))
        }) {
          Text(feed.isLiked ? "UnLike" : "Like")
        }.modifier(NormalButtonStyle())
      }
      
      // Comment list
      CommentListView(comments: feed.comments)
      
      // Bottom spacer
      Spacer()
        .layoutPriority(1000)
    }
  }
}
