import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  @discardableResult
  public override func reduce(action: ReduxActionProtocol) -> Self {
    let newFeeds = feeds.map { $0.reduce(action: action) }
    // Only reload UI if new `feeds` differs from existing `feeds`.
    if newFeeds != feeds {
      self.feeds = newFeeds
    }
    return self
  }
  
}
