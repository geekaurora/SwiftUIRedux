import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    // No need of deep copy, SwiftUI decides wether to reload by List diff.
    feeds = feeds.map { $0.reduce(action: action) }
  }
  
}
