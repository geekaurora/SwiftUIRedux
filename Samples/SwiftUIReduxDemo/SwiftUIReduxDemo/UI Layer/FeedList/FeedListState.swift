import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  @discardableResult
  public override func reduce(action: ReduxActionProtocol) -> Self {
    let oldFeeds = feeds.map { $0.codableCopy() }
    let newFeeds = feeds.map { $0.reduce(action: action) }
    if newFeeds != oldFeeds {
      self.feeds = newFeeds
    }
    return self
  }
  
}
