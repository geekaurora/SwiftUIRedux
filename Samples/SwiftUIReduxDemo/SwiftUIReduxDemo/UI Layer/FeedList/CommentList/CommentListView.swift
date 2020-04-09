import SwiftUI
import SwiftUIKit
import SwiftUIRedux
import CZUtils

struct CommentCell: View {
  let comment: Comment
  
  var body: some View {
    HStack {
      Text(comment.title)
        .modifier(CommentTextStyle())
      
      Spacer()
      Button(action: {
        print("tapped like.")
        dispatch(action: CommentLikeAction(comment: self.comment))
      }) {
        Text(comment.isLiked ? "UnLike" : "Like")
      }
      .modifier(NormalButtonStyle())
    }
  }
  
}

struct CommentListView: View {
  var comments: [Comment]
  
  var body: some View {
    return VStack {
      Spacer(minLength: 5)
      ForEach(comments) { comment in
          CommentCell(comment: comment)
      }
    }
    .padding(.leading, 5)
  }
}
