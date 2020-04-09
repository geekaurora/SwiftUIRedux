import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct CommentCell: View {
  let comment: Comment
  var body: some View {
    HStack {
      Text(comment.title)
        .modifier(ContentTextStyle())
      
      Spacer()
      Button(action: {
        print("tapped like.")
        dispatchLikeCommentAction(comment: self.comment)
      }) {
        Text(comment.isLiked ? "UnLike" : "Like")
      }
      .modifier(NormalButtonStyle())
    }
  }
  
}

struct CommentListView: View {
  @ObservedObject
  var state = CommentListState()
  
  var body: some View {
    return List {
      ForEach(state.comments) { comment in
        NavigationLink(destination: CommentDetailsView(comment: comment)) {
          CommentCell(comment: comment)
        }
      }
    }
    
  }
}
