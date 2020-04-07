import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  @discardableResult
  public override func reduce(action: ReduxActionProtocol) -> Self {
    // No need to deep copy, SwiftUI will decide wether to reload based on `feeds` diff.
    feeds.forEach { $0.reduce(action: action) }
    return self
  }
  
}
