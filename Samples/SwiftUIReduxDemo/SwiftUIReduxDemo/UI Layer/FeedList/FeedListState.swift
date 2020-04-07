import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  @discardableResult
  public override func reduce(action: ReduxActionProtocol) -> Self {
    self.feeds = feeds.map { $0.reduce(action: action)}
    return self
  }
  
}
