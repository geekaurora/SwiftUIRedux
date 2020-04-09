import SwiftUI
import SwiftUIRedux
import CZUtils

public class CommentListState: Subscriber, ObservableObject {
  
  @Published var comments: [Comment] = Comment.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    // No need of deep copy, SwiftUI decides wether to reload by List diff.
    comments = comments.map { $0.reduce(action: action) }
  }
  
}