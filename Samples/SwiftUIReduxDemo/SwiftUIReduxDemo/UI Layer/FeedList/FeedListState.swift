import SwiftUI
import SwiftUIRedux
import CZUtils

public class FeedListState: Subscriber, ObservableObject {
  
  @Published var feeds: [Feed] = Feed.mocks
  
  public override func reduce(action: ReduxActionProtocol) {
    //self.feeds = feeds.forEach { $0.reduce(action: action)}
  }
  
}
